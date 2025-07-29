# NOTE: This script can be modified for different atomic structures, 
# units, etc. See in.elastic for more info.
#

# Define the finite deformation size. Try several values of this
# variable to verify that results do not depend on it.
variable up equal 1.0e-6
 
# Define the amount of random jiggle for atoms
# This prevents atoms from staying on saddle points
variable atomjiggle equal 1.0e-5

# Uncomment one of these blocks, depending on what units
# you are using in LAMMPS and for output

# metal units, elastic constants in eV/A^3
#units		metal
#variable cfac equal 6.2414e-7
#variable cunits string eV/A^3

# metal units, elastic constants in GPa
units		metal
variable cfac equal 1.0e-4
variable cunits string GPa

# real units, elastic constants in GPa
#units		real
#variable cfac equal 1.01325e-4
#variable cunits string GPa

# Define minimization parameters
variable etol equal 0.0 
variable ftol equal 1.0e-10
variable maxiter equal 100000
variable maxeval equal 100000
variable dmax equal 1.0e-2

# generate the box and atom positions using a diamond lattice
variable	a equal 3.552 

boundary	p p p

lattice         fcc $a 
region		box prism 0 8.0 0 8.0 0 8.0 0.0 0.0 0.0
create_box	5 box 

create_atoms	1 box
set		type 1 type/ratio 5 ${prop} $r
set		type 1 type/ratio 2 0.5 $r
set		type 1 type/ratio 3 0.5 $r
set		type 2 type/ratio 4 0.5 $r

# Need to set mass to something, just to satisfy LAMMPS
mass		1 55.847 # Fe 
mass		2 58.693 # Ni
mass		3 51.960 # Cr
mass		4 58.933 # Co
mass		5 63.546 # Cu


