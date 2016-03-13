import matplotlib.pyplot as plt
import numpy as np

with plt.xkcd():

    fig = plt.figure()
    ax = fig.add_axes((0.1, 0.2, 0.8, 0.7))
    ax.spines['right'].set_color('none')
    ax.spines['top'].set_color('none')
    ax.yaxis.set_ticks_position('left')
    ax.xaxis.set_ticks_position('bottom')
    
    xticks = np.array(range(0,97,7) + [100])
    plt.xticks(xticks)
    ax.set_ylim([0, 1800])
    
    plt.axis([0,100,0,1800])

    weeks = 13
    mortenXAxis = range(0,1+7*weeks,7)
    mortenYAxis = [0,167,303,453,566,718,867,1029,1168,1277,1407,1540,1672,1760]
    
    lauraXAxis = [0,14,21,28,35,42,49,56,63,70,77]
    lauraYAxis = [0,379,584,771,917,1055,1196,1340,1480,1618,1760]

    plt.plot(mortenXAxis, mortenYAxis)

    plt.plot(range(98),range(0,1760,18))
    plt.plot(lauraXAxis, lauraYAxis, 'g')

    plt.xlabel('days of challenge')
    plt.ylabel('kanji learned')
    fig.text(
        0.5, 0.05,
        'The Kanji Damage Challenge Graph',
        ha='center')

plt.savefig("images/kanjidamagestatus.png")
