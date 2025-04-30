#!/usr/bin/awk -f

BEGIN {
    HORZ = "─"; VERT = "│"
    TOP_LEFT = "┌"; TOP_RIGHT = "┐";
    BOTTOM_LEFT = "└"; BOTTOM_RIGHT = "┘"
    TOP_INTERSECT = "┬";  BOTTOM_INTERSECT = "┴"
    MIDDLE_INTERSECT = "┼"; MIDDLE_LEFT = "├"; MIDDLE_RIGHT = "┤"
}

function hline(char, width) {
    line = sprintf("%*s", width, "")
    gsub(/ /, char, line)
    return line
}

BEGIN {
    error = 0
    if (ARGC < 2) {
        printf "Usage: %s <directory>\n", ENVIRON["_"] > "/dev/stderr"
        error = 1; exit
    }

    path = ARGV[1]
    if (system(sprintf("test -e %s", path)) != 0) {
        printf "Directory `%s` does not exist or cannot be accessed.\n", path > "/dev/stderr"
        error = 1; exit
    }

    header["name"] = "File Name"
    header["size"] = "Size (KB)"

    max_len["name"] = length(header["name"])
    max_len["size"] = length(header["size"])

    count = 0
    cmd = sprintf("ls -l --block-size=1 %s", path)

    while ((cmd | getline) > 0) {
        if ($0 ~ /^total/) continue

        size_bytes = $5
        size_kb = sprintf("%.2f", size_bytes / 1024)

        filename = $9

        files[count] = filename
        sizes[count] = size_kb
        count++;

        if (length(filename) > max_len["name"]) max_len["name"] = length(filename)
        if (length(size_kb) > max_len["size"]) max_len["size"] = length(size_kb)
    }

    close(cmd); exit
}

function print_separator(left, middle, right) {
    printf "%s%s%s%s%s\n", left, hline(middle, max_len["name"]), middle, hline(middle, max_len["size"]), right
}

function print_table() {
    print_separator(TOP_LEFT, HORZ, TOP_RIGHT)
    printf "%s%-*s%s%-*s%s\n", VERT, max_len["name"], header["name"], VERT, max_len["size"], header["size"], VERT
    print_separator(MIDDLE_LEFT, HORZ, MIDDLE_RIGHT)

    for (i = 0; i < count; i++) {
        printf "%s%-*s%s%*s%s\n", VERT, max_len["name"], files[i], VERT, max_len["size"], sizes[i], VERT
    }

    print_separator(BOTTOM_LEFT, HORZ, BOTTOM_RIGHT)
}

END {
    if (error) exit error

    printf "List of %s\n", path
    print_table()
    printf "Total: %s\n", count
}
