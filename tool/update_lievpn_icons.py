import os
from PIL import Image, ImageDraw, ImageOps, ImageEnhance

def generate_icons():
    src_path = 'assets/images/lievpn_logo.png'
    if not os.path.exists(src_path):
        src_path = 'lievpn_logo.png'
        
    src = Image.open(src_path).convert('RGBA')
    bbox = src.getbbox()
    cropped = src.crop(bbox)

    cw, ch = cropped.size
    max_dim = max(cw, ch)
    target_size = int(max_dim * 1.15)
    base_colored = Image.new('RGBA', (target_size, target_size), (0, 0, 0, 0))
    offset = ((target_size - cw) // 2, (target_size - ch) // 2)
    base_colored.paste(cropped, offset, cropped)

    # Status 1: Disconnected (Monochrome silver/slate)
    r, g, b, a = base_colored.split()
    gray = ImageOps.grayscale(base_colored)
    mono = Image.merge('RGBA', (gray, gray, gray, a))
    status1_hi = ImageEnhance.Brightness(mono).enhance(0.9)

    # Status 2: Active Proxy (Full vibrant color)
    status2_hi = base_colored.copy()

    # Status 3: Active TUN (Vibrant color + green badge)
    status3_hi = base_colored.copy()
    draw = ImageDraw.Draw(status3_hi)
    bw = int(target_size * 0.28)
    bx1 = target_size - bw - int(target_size * 0.04)
    by1 = target_size - bw - int(target_size * 0.04)
    bx2 = bx1 + bw
    by2 = by1 + bw
    draw.ellipse([bx1 - 4, by1 - 4, bx2 + 4, by2 + 4], fill=(15, 23, 42, 230))
    draw.ellipse([bx1, by1, bx2, by2], fill=(16, 185, 129, 255))
    pad = int(bw * 0.28)
    draw.ellipse([bx1 + pad, by1 + pad, bx2 - pad, by2 - pad], fill=(255, 255, 255, 255))

    # Export App Icons
    icon_640 = base_colored.resize((640, 640), Image.Resampling.LANCZOS)
    icon_640.save('assets/images/icon.png', format='PNG')

    ico_sizes = [(16, 16), (24, 24), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)]
    base_colored.save('assets/images/icon.ico', format='ICO', sizes=ico_sizes)
    if os.path.exists('windows/runner/resources/app_icon.ico'):
        base_colored.save('windows/runner/resources/app_icon.ico', format='ICO', sizes=ico_sizes)

    # Export Tray Icons Unix
    scales = {
        '': (18, 18),
        '/2.0x': (36, 36),
        '/3.0x': (54, 54),
        '/4.0x': (72, 72),
    }

    icons = {
        'status_1': status1_hi,
        'status_2': status2_hi,
        'status_3': status3_hi,
    }

    for name, hi_img in icons.items():
        for sub, size in scales.items():
            out_dir = f'assets/images/tray/unix{sub}'
            os.makedirs(out_dir, exist_ok=True)
            scaled = hi_img.resize(size, Image.Resampling.LANCZOS)
            scaled.save(f'{out_dir}/{name}.png', format='PNG')
            
        win_sizes = [(16, 16), (24, 24), (32, 32), (48, 48), (64, 64)]
        hi_img.save(f'assets/images/tray/windows/{name}.ico', format='ICO', sizes=win_sizes)

    print('Generated all icons successfully!')

if __name__ == '__main__':
    generate_icons()
