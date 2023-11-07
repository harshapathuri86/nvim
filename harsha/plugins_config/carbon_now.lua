require("carbon-now").setup({
    base_url = "https://carbon.now.sh/",
    open_cmd = "xdg-open",
    options = {
        theme = "monokai",
        window_theme = "none",
        font_family = "JetBrains Mono",
        font_size = "16px",
        bg = "gray",
        line_numbers = true,
        line_height = "133%",
        drop_shadow = true,
        drop_shadow_offset_y = "20px",
        drop_shadow_blur = "68px",
        width = "1000px",
        watermark = false,
    },
})
