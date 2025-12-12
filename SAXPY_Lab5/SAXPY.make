all: host
host: host.cpp
	g++ -O2 host.cpp -o host -lOpenCL
clean:
	rm -f host