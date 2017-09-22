var cut_msg = ""

function cut_begin() {
    cut_msg += mp.get_property("time-pos")
}

function cut_end() {
    var filename = mp.get_property("filename")
    cut_msg += " " + mp.get_property("time-pos") + "\n"
	mp.utils.write_file("file://" + filename + ".time.txt", cut_msg)
}

function cut_run() {
    var filename = mp.get_property("filename")
	mp.utils.write_file("file://cut_run.sh", "~/.bin/makevideo \"" + filename + "\" \"" + filename + ".time.txt\"")
    mp.utils.subprocess({"args":["run-wsl-file", "cut_run.sh"]})
}

mp.add_key_binding("i", "cut_begin", cut_begin)
mp.add_key_binding("n", "cut_end", cut_end)
mp.add_key_binding("c", "cut_run", cut_run)
