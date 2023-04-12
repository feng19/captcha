use std::io::Write;
use captcha::{gen, by_name, Captcha, CaptchaName, Difficulty, Geometry};
use captcha::filters::{Cow, Dots, Grid, Noise, Wave};
use rustler::{Binary, Env, NewBinary, NifTaggedEnum, NifUntaggedEnum, NifUnitEnum, NifStruct};

#[derive(NifUnitEnum)]
pub enum DifficultyEnum {
    Easy,
    Medium,
    Hard,
}

#[derive(NifUnitEnum)]
pub enum CaptchaNameEnum {
    Amelia,
    Lucy,
    Mila,
}

#[derive(NifUnitEnum)]
pub enum DirectionEnum {
    Horizontal,
    Vertical,
}

#[derive(NifStruct)]
#[module = "Captcha.Native.Geometry"]
pub struct GeometryOption {
    left: u32,
    right: u32,
    top: u32,
    bottom: u32,
}

#[derive(NifStruct)]
#[module = "Captcha.Native.Filter.Cow"]
pub struct FilterCow {
    min_radius: u32,
    max_radius: u32,
    n: u32,
    allow_duplicates: bool,
    geometry: Option<GeometryOption>,
}

#[derive(NifStruct)]
#[module = "Captcha.Native.Filter.Dots"]
pub struct FilterDots {
    n: u32,
    min_radius: u32,
    max_radius: u32,
}

#[derive(NifStruct)]
#[module = "Captcha.Native.Filter.Grid"]
pub struct FilterGrid {
    x_gap: u32,
    y_gap: u32,
}

#[derive(NifStruct)]
#[module = "Captcha.Native.Filter.Noise"]
pub struct FilterNoise {
    prob: f32,
}

#[derive(NifStruct)]
#[module = "Captcha.Native.Filter.Wave"]
pub struct FilterWave {
    f: f64,
    amp: f64,
    direction: DirectionEnum,
}

#[derive(NifUntaggedEnum)]
pub enum FilterOption {
    Cow(FilterCow),
    Dots(FilterDots),
    Grid(FilterGrid),
    Noise(FilterNoise),
    Wave(FilterWave),
}

#[derive(NifTaggedEnum)]
pub enum CreateOption {
    AddChars(u32),
    SetChars(String),
    View { w: u32, h: u32 },
    SetColor { r: u8, g: u8, b: u8 },
    Filters(Vec<FilterOption>),
}

#[rustler::nif(schedule = "DirtyCpu")]
fn create(env: Env, options: Vec<CreateOption>) -> Option<(String, Binary)> {
    let mut c = Captcha::new();
    apply_options(&mut c, &options);
    as_tuple(env, c)
}

#[rustler::nif(schedule = "DirtyCpu")]
fn easy(env: Env, options: Option<Vec<CreateOption>>) -> Option<(String, Binary)> {
    let mut c = gen(Difficulty::Easy);
    match options {
        Some(os) => { apply_options(&mut c, &os); }
        _ => ()
    };
    as_tuple(env, c)
}

#[rustler::nif(schedule = "DirtyCpu")]
fn medium(env: Env, options: Option<Vec<CreateOption>>) -> Option<(String, Binary)> {
    let mut c = gen(Difficulty::Medium);
    match options {
        Some(os) => { apply_options(&mut c, &os); }
        _ => ()
    };
    as_tuple(env, c)
}

#[rustler::nif(schedule = "DirtyCpu")]
fn hard(env: Env, options: Option<Vec<CreateOption>>) -> Option<(String, Binary)> {
    let mut c = gen(Difficulty::Hard);
    match options {
        Some(os) => { apply_options(&mut c, &os); }
        _ => ()
    };
    as_tuple(env, c)
}

#[rustler::nif(schedule = "DirtyCpu")]
fn create_by_name(env: Env, t: CaptchaNameEnum, d: DifficultyEnum, options: Option<Vec<CreateOption>>) -> Option<(String, Binary)> {
    let difficulty = match d {
        DifficultyEnum::Easy => Difficulty::Easy,
        DifficultyEnum::Medium => Difficulty::Medium,
        DifficultyEnum::Hard => Difficulty::Hard,
    };

    let captcha_name = match t {
        CaptchaNameEnum::Amelia => CaptchaName::Amelia,
        CaptchaNameEnum::Lucy => CaptchaName::Lucy,
        CaptchaNameEnum::Mila => CaptchaName::Mila,
    };

    let mut c = by_name(difficulty, captcha_name);
    match options {
        Some(os) => { apply_options(&mut c, &os); }
        _ => ()
    };
    as_tuple(env, c)
}

#[rustler::nif(schedule = "DirtyCpu")]
fn supported_chars() -> String {
    Captcha::new().supported_chars().iter().collect()
}

fn apply_options(c: &mut Captcha, options: &Vec<CreateOption>) {
    for option in options.iter() {
        match option {
            CreateOption::AddChars(n) => { c.add_chars(*n); }
            CreateOption::SetChars(string) => { c.set_chars(&*string.chars().collect::<Vec<char>>()); }
            CreateOption::View { w, h } => { c.view(*w, *h); }
            CreateOption::SetColor { r, g, b } => { c.set_color([*r, *g, *b]); }
            CreateOption::Filters(filters) => { for f in filters.iter() { apply_filter(c, &*f) }; }
        };
    };
}

fn apply_filter(c: &mut Captcha, f: &FilterOption) {
    match f {
        FilterOption::Cow(fc) => {
            let cow = match &fc.geometry {
                Some(g) => { Cow::new().area(Geometry::new(g.left, g.right, g.top, g.bottom)) }
                _none => { Cow::new() }
            };
            c.apply_filter(cow.circles(fc.n).min_radius(fc.min_radius).max_radius(fc.max_radius));
        }
        FilterOption::Noise(noise) => {
            c.apply_filter(Noise::new(noise.prob));
        }
        FilterOption::Dots(dots) => {
            c.apply_filter(Dots::new(dots.n).min_radius(dots.min_radius).max_radius(dots.max_radius));
        }
        FilterOption::Grid(grid) => {
            c.apply_filter(Grid::new(grid.x_gap, grid.y_gap));
        }
        FilterOption::Wave(wave) => {
            let w = Wave::new(wave.f, wave.amp);
            match wave.direction {
                DirectionEnum::Horizontal => { c.apply_filter(w.horizontal()); }
                DirectionEnum::Vertical => { c.apply_filter(w.vertical()); }
            };
        }
    };
}

fn as_tuple(env: Env, captcha: Captcha) -> Option<(String, Binary)> {
    match captcha.as_tuple() {
        None => None,
        Some((chars, png)) => Some((chars, to_binary(env, png)))
    }
}

fn to_binary(env: Env, v: Vec<u8>) -> Binary {
    let mut binary = NewBinary::new(env, v.len());
    binary.as_mut_slice().write_all(&v).unwrap();
    binary.into()
}

rustler::init!("Elixir.Captcha.Native", [create, easy, medium, hard, create_by_name, supported_chars]);
