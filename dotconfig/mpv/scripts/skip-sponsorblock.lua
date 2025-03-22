local skip_patterns = { "SponsorBlock" }

local last_chapter = -1
local user_seeked = false

local function should_skip(chapter)
    for _, pattern in ipairs(skip_patterns) do
        if chapter:match(pattern) then
            return true
        end
    end
    return false
end

local function check_chapter()
    local chapters = mp.get_property_native("chapter-list")
    if not chapters then return end

    local current = mp.get_property_number("chapter")
    if not current or current == last_chapter then return end

    local title = chapters[current + 1] and chapters[current + 1].title or ""

    if should_skip(title) and not user_seeked then
        mp.commandv("no-osd", "add", "chapter", 1)
    else
        user_seeked = false -- Reset after allowing playback
    end

    last_chapter = current
end

local function on_seek()
    user_seeked = true
end

mp.observe_property("chapter", "number", check_chapter)
mp.register_event("seek", on_seek)
