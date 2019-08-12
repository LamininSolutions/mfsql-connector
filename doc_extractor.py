#!/usr/bin/env python3

import sys, os

if len(sys.argv) < 2:
    print("usage: {} <input>\n".format(sys.argv[0]))
    sys.exit(1)

TAG = "rST"
START_TOKEN = "/*" + TAG + "**"
END_TOKEN   = "**" + TAG + "**"

OBJECT_TYPES = {
    "fnMF" : "functions",
    "spMF" : "procedures",
    "tb.MF" : "tables",
    "tMF" : "triggers",
    "MFvw" : "views",
    "script" : ""
}

filename = os.path.basename(sys.argv[1])[:-4]
file_type = ""
file_dir = ""

for t, d in OBJECT_TYPES.items():
    if (filename.find(t) != -1):
        file_type = t
        file_dir = d
        # remove prefix
        filename = filename[filename.find(file_type):] + ".rst"
        break

if (file_type == "script"):
    print("skipping script ({})".format(sys.argv[1]))
    sys.exit(0)

if (len(file_type) < 1):
    print("skipping input without mapped type ({})".format(sys.argv[1]))
    sys.exit(0)

doc = ""

with open(sys.argv[1], "r") as f:
    extracting = False

    for i, line in enumerate(f):
        if line.startswith(END_TOKEN):
            extracting = False
            continue
        if line.startswith(START_TOKEN):
            extracting = True
            continue
        if extracting:
            doc += line

if len(doc) > 0:
    with open(os.path.join("source", d, filename),  "w") as f:
        f.write(doc)
else:
    print("skipping input without documentation ({})".format(sys.argv[1]))
