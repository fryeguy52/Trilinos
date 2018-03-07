################################################################################
#
# Set up env on shiller/hansen for ATMD builds of Trilinos
#
# This source script gets the settings from the JOB_NAME var.
#
################################################################################

#only build on the front end

module purge

export OMPI_CXX=

export ATDM_CONFIG_SYSTEM_CDASH_SITE=ellis/bowman
export ATDM_CONFIG_USE_NINJA=ON
export ATDM_CONFIG_BUILD_COUNT=35
export ATDM_CONFIG_CTEST_PARALLEL_LEVEL=16
export OMP_NUM_THREADS=4

echo "Using ellis/bowman compiler stack $ATDM_CONFIG_COMPILER to build $ATDM_CONFIG_BUILD_TYPE code with Kokkos node type $ATDM_CONFIG_NODE_TYPE"

module load ninja/1.7.2

export ATDM_CONFIG_KOKKOS_ARCH=KNL
if [ "$ATDM_CONFIG_COMPILER" == "GNU" ]; then
    echo "GNU gcc not suppored on this machine"
    exit 1
elif [ "$ATDM_CONFIG_COMPILER" == "INTEL" ]; then
    module load devpack/openmpi/1.10.4/intel/17.0.098
    module swap gcc/4.7.4 gcc/4.9.3 
    module load seacas/20170220/openmpi/none/gcc/4.8.3
    module load yaml-cpp/20170104
    export OMPI_CXX=`which icpc`
    export OMPI_CC=`which icc`
    export OMPI_FC=`which ifort`
    export ATDM_CONFIG_LAPACK_LIB="-mkl"
    export ATDM_CONFIG_BLAS_LIB="-mkl"
elif [ "$ATDM_CONFIG_COMPILER" == "CUDA" ]; then
    echo "Cuda not suppored on this machine"
    exit 1
else
    echo "No valid compiler found"
fi

# Set MPI wrappers
export MPICC=`which mpicc`
export MPICXX=`which mpicxx`
export MPIF90=`which mpif90`

export ATDM_CONFIG_USE_HWLOC=OFF
export ATDM_CONFIG_HWLOC_LIBS=-lhwloc

export ATDM_CONFIG_HDF5_LIBS="-L${HDF5_ROOT}/lib;${HDF5_ROOT}/lib/libhdf5_hl.a;${HDF5_ROOT}/lib/libhdf5.a;-lz;-ldl"
export ATDM_CONFIG_NETCDF_LIBS="-L${BOOST_ROOT}/lib;-L${NETCDF_ROOT}/lib;-L${NETCDF_ROOT}/lib;-L${PNETCDF_ROOT}/lib;-L${HDF5_ROOT}/lib;${BOOST_ROOT}/lib/libboost_program_options.a;${BOOST_ROOT}/lib/libboost_system.a;${NETCDF_ROOT}/lib/libnetcdf.a;${PNETCDF_ROOT}/lib/libpnetcdf.a;${HDF5_ROOT}/lib/libhdf5_hl.a;${HDF5_ROOT}/lib/libhdf5.a;-lz;-ldl"

export ATDM_CONFIG_MPI_POST_FLAG="--map-by;numa:PE=16;-x;OMP_NUM_THREADS=4;-oversubscribe"

export ATDM_CONFIG_COMPLETED_ENV_SETUP=TRUE
