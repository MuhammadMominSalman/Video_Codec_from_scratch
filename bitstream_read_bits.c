/** \file bitstream_read_bits.c
 *
 * mex-c-function to read bits from a uint32 bitstream vector
 * vector=bitstream_read_bits(bitstream_uint32,nr_of_bits)
 *        returns a vector of size nr_of_bits consisting of the bits read from the bitstream
 * [vector bitstream]=bitstream_read_bits(bitstream_uint32,nr_of_bits)
 *        return a vecotr of size nr_of_bits and the bitstream with increased write pointer
 *
 * bitstream=uint32([ bitstream_length read_pointer write_pointer ..data..])
 *   bitstream_length: length of the bitstream in bits
 *   read and write pointers are set during reading and writing automatically
 *   ..data.. uint32 data consisting of the bits written to the bitstream 
 *
 * compile command: (tested for Linux AMD64 architecture using matlab7a R14 )
 *   mex bitstream_read_bits.c
 */

#include "mex.h"

void read_bits(double *output_vector, unsigned int bitstream_data, long *output_offset, int nr_of_bits)
{
  /*  mexPrintf ("Writing to %p from [0x%08X] to offset %ld overall %d bits\n",output_vector, bitstream_data, *output_offset,nr_of_bits);*/
  while (nr_of_bits-->0)
  {
    /* write the lowermost bit to output_vector*/
    output_vector[(*output_offset)++]=(double) (bitstream_data&1);
    /* get next bit*/
    bitstream_data>>=1;
  }
}

/* nlhs: number of "left-hand-side arguments" (number of return values)*/
/* nlrs: number of input values (right-hand-sided arguments)*/
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  /* Fehlermeldung: mexErrMsgTxt(""); beendet auch gleichzeitig die Funktion*/
  /* Warnungen: mexWarnMsgTxt("");*/
  /* Output: mexPrintf("format_str",...);*/
  
  unsigned int *bitstream;  
  double *nr_of_bits_ptr;
  unsigned int nr_of_bits;
  double *output_bits;
  unsigned long read_pointer;
  unsigned long read_pointer_uint32;
  long read_pointer_bit;
  long nr_of_uint32;
  unsigned long curr_uint32;
  long bits_read;

  /* check if correct number of input arguments are given */
  if (nrhs!=2)
  {
    mexPrintf("2 Arguments required! Usage: bitstream_read_bits(bitstream,nr_of_bits)\n");
    return;
  }
  /* check, if input arguments are of the correct class */
  if(mxGetClassID(prhs[0])!=mxUINT32_CLASS)
  {
    mexPrintf("First Argument must be UINT32 bitstream!\n");
    return;
  }
  if (mxGetClassID(prhs[1])!=mxDOUBLE_CLASS )
  {
    mexPrintf("Second argument must be a scalar double value\n");
    return;
  }
  /* get input data and setup pointers*/
  bitstream=(unsigned int*)mxGetData(prhs[0]);
  nr_of_bits_ptr=(double*)mxGetData(prhs[1]);
  nr_of_bits=(unsigned int)(nr_of_bits_ptr[0]);
  /* check, if number of bits do not exceed the size of the bitstream */
  if (bitstream[1]+nr_of_bits>bitstream[0])
  {
    mexPrintf("Trying to read %ld bits after %ld but only %ld bits available\n",nr_of_bits,bitstream[1],bitstream[0]);
    /* allocate empty matrix */
    plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    if (nlhs==2)
    {
      /* duplicate the bitstream if two output arguments are requested */
      plhs[1] = mxDuplicateArray(prhs[0]);
    }
    return;
  }
  /*  mexPrintf("Getting %lf bits from a bitstream of size %lu at offset %lu\n",nr_of_bits[0],bitstream[0],bitstream[1]);*/
  /* allocate memory for return codeword*/
  plhs[0] = mxCreateDoubleMatrix(1,nr_of_bits,mxREAL);
  output_bits = mxGetPr(plhs[0]);

  /* get pointers for reading the bitstream */
  read_pointer=bitstream[1]+3*32; /* c-notation !!!*/
  read_pointer_uint32=read_pointer/32;
  read_pointer_bit=read_pointer%32;
  /* get number of uint32 necessary (including the current one)*/
  nr_of_uint32=(read_pointer_bit+nr_of_bits)/32-1; /*read only full uint32 in while loop*/
  bits_read=0;
  /* get remaining bits from first uint32 of the bitstream*/
  if (nr_of_uint32>=0)
  {
    /* read the remaining bits from the bitstream */
    curr_uint32=bitstream[read_pointer_uint32++]>>read_pointer_bit;
    read_bits(output_bits,curr_uint32,&bits_read,32-read_pointer_bit);
    read_pointer_bit=0;
    /* read successive full uint32 words (length 32 bits)*/
    while(nr_of_uint32>0)
    {
      curr_uint32=bitstream[read_pointer_uint32++];
      read_bits(output_bits,curr_uint32,&bits_read,32);
      nr_of_uint32--;
    }
    /* read the remaining bits of the last uint32 (usually not all 32 bits)*/
    curr_uint32=bitstream[read_pointer_uint32];
    read_bits(output_bits,curr_uint32,&bits_read,nr_of_bits-bits_read);
  }
  else
  {
    /* read only from the current uint32 without going over uint32 boundaries*/
    curr_uint32=bitstream[read_pointer_uint32++]>>read_pointer_bit;
    read_bits(output_bits,curr_uint32,&bits_read,nr_of_bits);
    read_pointer_bit=0;
  }
  /*check, if a second output parameter is requested according to nlhs*/
  if (nlhs==2)
  {
    /* copy the input bitstream to the second output parameter and change the read_pointer */
    plhs[1] = mxDuplicateArray(prhs[0]);
    bitstream =(unsigned int*) mxGetPr(plhs[1]);
    bitstream[1]+=nr_of_bits;
  }
}
