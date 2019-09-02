from contextlib import contextmanager


filename="/tmp/111.log.server"

@contextmanager
def openfile(name, param):
    print("openfile(): " + name)
    f = open(name, param)
    try:
        yield f
    finally:
        f.close()
        print("is closing file: " + name)

with openfile(filename, "rw+") as f:
    line = f.readline()
    if line.find("git") == -1:
        print(line)
    while line:
        line = f.readline()
        if line.find("git") == -1:
            print(line)
