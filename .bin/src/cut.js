var cut_msg = ""
var filename = ""
var start_time = 0
var cut_times = 1

function load_file() {
    try {
        cut_msg = mp.utils.read_file(filename + ".time.txt")
    } catch (e) {
        print(e)
    }
}

function cut_begin() {
    start_time = mp.get_property("time-pos")

    var start_time_str = Math.floor(start_time / 60 / 60)
        + ":" + Math.floor(start_time / 60 % 60)
        + ":" + Math.floor(start_time % 60 * 1000) / 1000
    mp.osd_message(cut_times + " : " + start_time_str, 10000)
}

function cut_end() {
    mp.osd_message("")

    if (filename == "") {
        filename = mp.get_property("filename")
    }

    load_file()
    cut_msg += start_time + " " + mp.get_property("time-pos") + "\n"
	mp.utils.write_file("file://" + filename + ".time.txt", cut_msg)
    start_time = -1
    cut_times++
}

function cut_run() {
    if (filename == "") {
        filename = mp.get_property("filename")
    }

    if (start_time != -1) {
        load_file()
        cut_msg += start_time + " " + mp.get_property("duration") + "\n"
        mp.utils.write_file("file://" + filename + ".time.txt", cut_msg)
    }

	mp.utils.write_file("file://0_cut_run.sh", "~/.bin/makevideo \"" + filename + "\" \"" + filename + ".time.txt\"")
    mp.utils.subprocess({"args":["run-wsl-file", "0_cut_run.sh"]})
}

mp.add_key_binding("i", "cut_begin", cut_begin)
mp.add_key_binding("n", "cut_end", cut_end)
mp.add_key_binding("c", "cut_run", cut_run)
