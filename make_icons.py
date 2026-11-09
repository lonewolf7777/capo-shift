# Erzeugt die App-Icons (Griffbrett mit Capo) in den Ordner "site".
from PIL import Image, ImageDraw
def icon(size, maskable=False, rounded=True):
    S=size*4
    im=Image.new('RGBA',(S,S),(0,0,0,0)); d=ImageDraw.Draw(im)
    bg=(28,22,18,255)
    if maskable or not rounded: d.rectangle((0,0,S,S),fill=bg)
    else: d.rounded_rectangle((0,0,S-1,S-1),radius=int(S*0.22),fill=bg)
    pad=int(S*(0.22 if maskable else 0.14))
    x0,x1=pad,S-pad; y0,y1=int(S*0.26),int(S*0.74)
    d.rounded_rectangle((x0,y0,x1,y1),radius=int(S*0.03),fill=(54,41,31,255))
    for i in range(6):
        y=y0+(y1-y0)*(0.1+i*0.16); w=max(2,int(S*(0.004+i*0.0018)))
        d.rectangle((x0,y-w/2,x1,y+w/2),fill=(234,226,208,200))
    fx=x0+(x1-x0)*0.72; d.rectangle((fx,y0,fx+S*0.022,y1),fill=(198,203,211,255))
    cx=x0+(x1-x0)*0.55; d.rounded_rectangle((cx-S*0.045,y0-S*0.07,cx+S*0.045,y1+S*0.07),radius=int(S*0.045),fill=(226,168,70,255))
    d.rectangle((x0,y0,x0+S*0.03,y1),fill=(234,226,208,255))
    return im.resize((size,size),Image.LANCZOS)
icon(192).save('site/icon-192.png'); icon(512).save('site/icon-512.png')
icon(512,maskable=True).save('site/icon-maskable-512.png')
icon(180,rounded=False).convert('RGB').save('site/apple-touch-icon.png')
icon(64).save('site/favicon.png')
