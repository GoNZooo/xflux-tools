bin: location

location:
	raco exe -o bin/location src/location.rkt

clean:
	rm bin/*
