import datetime
import csv
import shutil
import sys
import os
from urllib.request import urlretrieve

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates


def fetchIMMData(year, filepath=None):
    IMM_FILE = "deacot{}.zip".format(year)
    IMM_URL = "https://www.cftc.gov/files/dea/history/" + IMM_FILE
    if filepath is None:
        file_path = os.path.join('Data', 'imm')
    if not os.path.exists(file_path):
        os.mkdir(file_path)

    def progress(blocknum, bs, size):
        total_sz_mb = '%.2f MB' % (size/1e6)
        current_sz_mb = '%.2f MB' % (blocknum * bs / 1e6)
        sys.stdout.write('\rDownloaded %s / %s' % (current_sz_mb, total_sz_mb))

    print("Downloading %s into %s" % (IMM_URL, file_path))
    archive_path = os.path.join(file_path, IMM_FILE)
    urlretrieve(IMM_URL, filename=archive_path, reporthook=progress)
    sys.stdout.write("\n")
    sys.stdout.write('Unzipping %s to directory %s' % (archive_path, year))
    shutil.unpack_archive(archive_path, os.path.join(file_path, str(year)))
    print(' -- done.')

def plotimm(data, title, currency):
    plt.style.use('ggplot')
    #fig = plt.figure(figsize=(12,8))
    fig = plt.figure()
    ax = fig.add_subplot()
    ax.bar(data[:, 0], data[:, 1], width=5, label="{} Long".format(currency))
    ax.bar(data[:, 0], data[:, 2], width=5, label="{} Short".format(currency))
    ax.plot(data[:, 0], data[:, 3], 'o-k', linewidth=2, label="Delta")
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%y-%m-%d'))
    ax.legend(loc="lower right")
    plt.title(title)
    fig.autofmt_xdate()
    plt.tight_layout()
    plt.show()

if __name__ == '__main__':
    jpy, euro, gbp = [], [], []
    for year in [2020, 2021]:
        fetchIMMData(year)
        with open('Data/imm/{}/annual.txt'.format(year), newline='') as csvfile:
            for row in csv.reader(csvfile, delimiter=','):
                if row[0] == "JAPANESE YEN - CHICAGO MERCANTILE EXCHANGE":
                    dt = datetime.datetime.strptime(row[2], "%Y-%m-%d")
                    jpy.append([dt, int(row[8]), -int(row[9]), int(row[8]) - int(row[9])])
                if row[0] == "EURO FX - CHICAGO MERCANTILE EXCHANGE":
                    dt = datetime.datetime.strptime(row[2], "%Y-%m-%d")
                    euro.append([dt, int(row[8]), -int(row[9]), int(row[8]) - int(row[9])])
                if row[0] == "BRITISH POUND STERLING - CHICAGO MERCANTILE EXCHANGE":
                    dt = datetime.datetime.strptime(row[2], "%Y-%m-%d")
                    gbp.append([dt, int(row[8]), -int(row[9]), int(row[8]) - int(row[9])])
    jpy = np.array(sorted(jpy, key=lambda x: x[0]))
    euro = np.array(sorted(euro, key=lambda x: x[0]))
    gbp = np.array(sorted(gbp, key=lambda x: x[0]))
    print("Japanese Yen", jpy[-3:])
    print("Euro", euro[-3:])
    print("Pound", gbp[-3:])
    plotimm(jpy, "CME Non-Commercial Currency Option (JPY/USD)", "JPY")
    plotimm(euro, "CME Non-Commercial Currency Option (EUR/USD)", "EUR")
    plotimm(gbp, "CME Non-Commercial Currency Option (GBP/USD)", "GBP")



