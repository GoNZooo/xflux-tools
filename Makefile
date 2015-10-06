bin: location

location:
	raco exe -o bin/xflux-location src/xflux-location.rkt

clean:
	rm bin/*
