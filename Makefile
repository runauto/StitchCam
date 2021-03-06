################################################################################
# Makefile for Jetson TK1
################################################################################

SRCS = MyBlender.cpp \
	MyCompensator.cpp \
	MySeamFinder.cpp \
	MyStitcher.cpp \
	MyWarper.cpp \
	WebCam.cpp \
	main.cpp

OBJS = \
	MyBlender.o \
	MyCompensator.o \
	MySeamFinder.o \
	MyStitcher.o \
	MyWarper.o \
	WebCam.o \
	main.o 

CUDA_SRCS = Blender.cu \
	Compensator.cu

CUDA_OBJS = \
	Blender.o \
	Compensator.o

CFLAGS = -O3 -march=armv7 -fopenmp -DJETSON_TK1
LFLAGS = -L/usr/local/lib 

CUDA_CFLAGS = -O3 -target-cpu-arch ARM -m32 -DJETSON_TK1
CUDA_LFLAGS = --cudart static --relocatable-device-code=false -gencode arch=compute_30,code=sm_30 -gencode arch=compute_32,code=sm_32 -link -L/usr/local/cuda/lib 

NVCC = nvcc
GCC = g++


LIBS := -lopencv_core -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_stitching -lgomp


all: Stitch

Stitch: $(OBJS) $(CUDA_OBJS)
	$(NVCC) $(CUDA_LFLAGS) $(LFLAGS) -o "Stitch" $(OBJS) $(CUDA_OBJS) $(LIBS)

$(OBJS): $(SRCS)
	$(GCC) -c $(CFLAGS) $?

$(CUDA_OBJS): $(CUDA_SRCS)
	$(NVCC) -c $(CUDA_CFLAGS) $?

clean:
	-$(RM) $(CU_DEPS)$(OBJS)$(C++_DEPS)$(C_DEPS)$(CC_DEPS)$(CPP_DEPS)$(EXECUTABLES)$(CXX_DEPS)$(C_UPPER_DEPS) StitchCam
	-@echo ' '

