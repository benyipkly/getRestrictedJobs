import csv
import numpy as np
import io

restrictedProjects = []
restrictedJob = []
jobsarr = np.genfromtxt(fname="jobs.csv", delimiter='\t', names=True, dtype=None)
with open('projects.csv', 'rt') as csvfile:
    projreader = csv.reader(csvfile, delimiter=',', quotechar='\"')
    for row in projreader:
        restrictedProjects.append(row[1])
t = np.in1d(jobsarr['account'], restrictedProjects)
np.savetxt('restrictedJobs.csv', jobsarr[t], header='\t'.join(jobsarr.dtype.names), fmt='%s\t%s\t%s\t%s\t%s\t%i', comments='')

