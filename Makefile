pkg="git git-core"
CWD=$(pwd)

test:
	echo $CWD

reqs:
	@echo ":::::::::::::::::::::::: Installation of reqs ::::::::::::::::::::::::"
	@sudo apt install $(pkg)

ffmpeg-dl: reqs
	@echo ":::::::::::::::::::::::: Download of ffmpeg ::::::::::::::::::::::::"
	-@git clone https://github.com/FFmpeg/FFmpeg.git 


ffmpeg-conf: ffmpeg-dl
	@echo ":::::::::::::::::::::::: Installation of ffmpeg ::::::::::::::::::::::::"
	@echo ":::::::::::::::::::::::: Can take up to 20 minutes ::::::::::::::::::::::::"
	@cd ./FFmpeg && ./configure && make -j4 && sudo make install

install: ffmpeg-conf
	@echo ":::::::::::::::::::::::: Installation complete ::::::::::::::::::::::::"

clean:
	@echo ":::::::::::::::::::::::: Cleaning ::::::::::::::::::::::::"
	@sudo rm -rf *~ FFmpeg

