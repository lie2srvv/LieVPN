#[cfg(not(target_os = "ios"))]
mod console;

#[cfg(not(target_os = "ios"))]
use rquickjs::{CatchResultExt, Context, Function, Runtime, Value};
#[cfg(not(target_os = "ios"))]
use std::time::{Duration, Instant};

#[cfg(not(target_os = "ios"))]
const ENTRY: &str = "main";
#[cfg(not(target_os = "ios"))]
const TIMEOUT: Duration = Duration::from_secs(10);
#[cfg(not(target_os = "ios"))]
const MEMORY_LIMIT: usize = 256 * 1024 * 1024;

#[cfg(not(target_os = "ios"))]
pub fn evaluate(script: &str, config: &str) -> Result<String, String> {
    evaluate_within(script, config, TIMEOUT)
}

#[cfg(target_os = "ios")]
pub fn evaluate(_script: &str, config: &str) -> Result<String, String> {
    Ok(config.to_string())
}

#[cfg(not(target_os = "ios"))]
fn evaluate_within(script: &str, config: &str, timeout: Duration) -> Result<String, String> {
    let runtime = Runtime::new().map_err(|e| format!("{e}"))?;
    runtime.set_memory_limit(MEMORY_LIMIT);
    let deadline = Instant::now() + timeout;
    runtime.set_interrupt_handler(Some(Box::new(move || Instant::now() >= deadline)));

    let context = Context::full(&runtime).map_err(|e| format!("{e}"))?;
    context.with(|ctx| {
        console::install(&ctx).catch(&ctx).map_err(describe)?;
        ctx.eval::<Value, _>(script.as_bytes())
            .catch(&ctx)
            .map_err(describe)?;
        let entry: Function = ctx
            .eval(ENTRY.as_bytes())
            .map_err(|_| format!("script does not define {ENTRY}()"))?;
        let parsed: Value = ctx
            .json_parse(config)
            .catch(&ctx)
            .map_err(|_| "profile is not valid JSON".to_owned())?;
        let result: Value = entry.call((parsed,)).catch(&ctx).map_err(describe)?;
        ctx.json_stringify(result)
            .catch(&ctx)
            .map_err(describe)?
            .and_then(|s| s.to_string().ok())
            .ok_or_else(|| "main() returned a non-serializable value".to_owned())
    })
}

#[cfg(not(target_os = "ios"))]
fn describe(error: rquickjs::CaughtError<'_>) -> String {
    format!("{error}")
}
