#!/usr/bin/env python
#
# Script to show upcoming birthdays, anniversaries, etc. The dates are
# in a separate file (name below).
#
# To use this, include it in your .bashrc or .profile, and you will see
# the output every time you log in or start a new shell.
#
# Andreas Kaempf, Soundience Ltd.
# andreas.kaempf@soundience.com
# www.soundience.com

import datetime
import os

# Name of the text file containing your anniversary dates
afile = os.environ['HOME'] + '/.anniversaries'

# The number of days into the future to look (e.g., 30 to show
# birthdays up to 30 days from now)
threshold = 30

# Get today's date, for comparison
today = datetime.datetime.now().date()

# Read file and collect list of events that are up to n days in the future
alist = []

for l in open(afile).readlines():

    # Ignore blank lines and comments
    l = l.strip()
    if len(l) == 0 or l[0] == '#':
        continue

    # Set year so that date is upcoming (i.e., change 10/11/2007 to
    # 10/11/2013 if it is now 2013)
    try:
        dt = l[:l.find(' ')]
        info = l[l.find(' ')+1:].strip()
        dmy = [int(x) for x in dt.split('/')]
        if len(dmy) == 2:
            dmy.append(today.year)
        dd, mm, yy = dmy
        d = datetime.date(yy, mm, dd)
        if d < today:
            d = datetime.date(today.year, mm, dd)
        if d < today:
            d = datetime.date(d.year + 1, mm, dd)
    except:
        print 'Line not valid:', l
        continue

    # Add to list if within threshold days
    days = (d - today).days
    if days <= threshold:
        alist.append((days, info, dt))

# Sort and print the list of days
if alist:
    print 'BIRTHDAYS AND ANNIVERSARIES NEXT %d DAYS' % threshold
    alist.sort(lambda a,b : cmp(a[0], b[0]))
    for a in alist:
        days, info, dt = a
        print '%s (%s, %d days)' % (info, dt, days)

