# SOD Notes and Bugs

## Notes

### Restricted Data

SOD and IRISWS is used to download restriced data in Alaska at [ZE](http://ds.iris.edu/mda/ZE/?starttime=2015-05-16T00:00:00&endtime=2017-07-17T23:59:59).

- IRISWS-Alaska-restricted.sh
- recipe-Alaska-restricted.xml


## Bugs

### bestChannelAtStation

I use SOD to download OBS data at [YH](http://ds.iris.edu/mda/YH/?starttime=2014-05-11T00:00:00&endtime=2015-06-22T23:59:59). There is a bug for the SOD subsetter, `bestChannelAtStation`. The horizontal component data are missing if `bestChannelAtStation` is used. YH has HHZ, HH1, and HH2, while the [orientation Code Heuristic](http://www.seis.sc.edu/sod/ingredients/bestChannelAtStation.html) are Z,N,E,1,2,3,U,V,W. It seems that we can only get Z if the components are Z12. The subsetter may cause potentail bug if we'd like to download three-component data.

Maybe we can report this issue to SOD.

We may write a post-processing script to choose the best channel instead of using this subsetter which may potentially miss data.


### Stations Working for Multiple Periods

There are 3 [IU.CHTO](http://ds.iris.edu/mda/IU/CHTO/) stations returned from the IRIS server, i.e.,

- startDate="1992-08-31T00:00:00" endDate="1997-10-17T04:15:00"
- startDate="1997-10-17T04:15:00" endDate="2009-09-19T07:28:36"
- startDate="2009-09-19T14:35:27"

If we have only one event, then it looks like it gets only one of the three and SOD works property. But with many events, it gets all three and unfortunately gets confused and uses the wrong one. If we divide the events up into three groups that overlap these time ranges, then each group will work. Please check the discussion in [SOD email list](https://groups.google.com/a/seis.sc.edu/g/sod/c/ID3rQkLxpsE).


### Missing Data at SSI

Be careful for the `bestChannelAtStation` bug when downloading three-component data. So I comment this subsetter in the recipe. For example, we can only get Z component for station AAK and event 19931201 if the subsetter is used, while we can get Z,E,1 component if we comment it. It seems that we can only get Z if the components are ZE1.

SSI seems miss data at some stations for some events using SOD, e.g., ARU. This bug may be related to the above IU.CHTO bug. [II.AAK](http://ds.iris.edu/mda/II/AAK/) only has one working period, 1990-10-12~2599-12-31. [II.ARU](http://ds.iris.edu/mda/II/ARU/) has two working periods, 2009-09-28~2018-09-08 and 1988-09-14~2009-09-27.

