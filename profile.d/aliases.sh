#!/bin/sh
has_program rg && alias grep=rg
has_program batcat && { alias ocat=/usr/bin/cat; alias cat=batcat; }
has_program bat && { alias ocat=/usr/bin/cat; alias cat=bat; }
has_program dust && alias du=dust
