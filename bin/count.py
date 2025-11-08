#!/usr/bin/env python3

#we want a script that will concatenate all of the verse output files and write a single counts matrix that will containing all of the samples 

# ghcr.io/bf528/pandas:latest 

import argparse
parser = argparse.ArgumentParser(description='Concatenate VERSE output files')
parser.add_argument("-i", "--input", help='A list of the VERSE output', dest="input", required=True, nargs='+')
parser.add_argument("-o", "--output", help='The output file name and path provided by snakemake', dest="output", required=True)

args = parser.parse_args()

import pandas as pd
import os

x=[]
for line in args.input:
    sample_id = os.path.basename(line).split('.')[0]
    df=pd.read_csv(line, sep='\t', header=0)
    df.rename(columns={'count': sample_id}, inplace=True)
    df.set_index('gene', inplace=True)
    x.append(df)

concat = pd.concat(x, axis=1)
concat.to_csv(args.output)
