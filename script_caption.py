import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

import sys
import torch
from lavis.models import load_model_and_preprocess
from PIL import Image

image_path = sys.argv[1]

raw_image = Image.open(image_path).convert("RGB")

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
# loads BLIP caption base model, with finetuned checkpoints on MSCOCO captioning dataset.
# this also loads the associated image processors
model, vis_processors, _ = load_model_and_preprocess(name="blip_caption", model_type="base_coco", is_eval=True, device=device)
# preprocess the image
# vis_processors stores image transforms for "train" and "eval" (validation / testing / inference)
image = vis_processors["eval"](raw_image).unsqueeze(0).to(device)
# generate caption

print(model.generate({"image": image})[0])
