
The fold contains all the SOD recipes I used to download seismic data from the FDSN web services (FDSNWS) of some Data Centers, e.g., [IRIS-DMC](https://ds.iris.edu/ds/nodes/dmc/). You can directly run them in your computer, e.g.,
```bash
$ sod -f recipe-csvEvent-fixedNet.xml
```

Due to IRIS-DMC has updated its StationXML, you need to use the latest SOD, i.e., [SOD 3.2.10](http://www.seis.sc.edu/sod/).

You may check all the [FDSNWS supporting Data Centers](https://www.fdsn.org/webservices/). Sometimes you can directly use their FDSNWS via [wget](https://www.gnu.org/software/wget/) or [curl](https://curl.haxx.se/). Some of them may also have their own web services, which could be useful, e.g.,, [IRIS-DMC web services](https://service.iris.edu/).

**Content:**

- [eventArm](#eventarm)
- [networkArm](#networkarm)
- [waveformArm](#waveformarm)
- [subsetter notes](#subsetter-notes)
- [tests](#tests)
- [references](#references)


## eventArm

Those recipes only contain the eventArm, which can be used to download the catalog called `events.csv`. You may revise, comment, or add some subsetters in the recipes according to your purposes.

- [recipe-origin-mag-dep-boxarea.xml](eventArm/recipe-origin-mag-dep-boxarea.xml) : Query catalog from [USGS FDSN Event web service](https://earthquake.usgs.gov/fdsnws/event/1/), within a box area.
- [recipe-origin-mag-dep-boxarea-more.xml](eventArm/recipe-origin-mag-dep-boxarea-more.xml) : Query catalog with more conditions.
- [recipe-origin-mag-dep-pointdist.xml](eventArm/recipe-origin-mag-dep-pointdist.xml) : Query catalog within given distance range of the given lat & lon.
- [recipe-origin-mag-dep-boxarea-NC.xml](eventArm/recipe-origin-mag-dep-boxarea-NC.xml) : Query catalog from [Northern California Earthquake Data Center (NCEDC) FDSNWS](http://service.ncedc.org/).


## networkArm

Those recipes only contain the networkArm, which can be used to search stations, including locations (`station.dat`) and instrument responses (`poles and zeros` and/or `responses`). You may revise, comment, or add some subsetters in the recipes according to your purposes.

- [recipe-fixed-net-sta.xml](networkArm/recipe-fixed-net-sta.xml) : Query seismic stations from [IRIS-DMC FDSNWS](http://service.iris.edu/fdsnws/), with specic networks and stations.
- [recipe-boxarea.xml](networkArm/recipe-boxarea.xml) : Query seismic stations within a box area.
- [recipe-pointdist.xml](networkArm/recipe-pointdist.xml) : Query seismic stations within given distance range of the given lat & lon.
- [recipe-boxarea-NC.xml](networkArm/recipe-boxarea-NC.xml) : Query seismic stations from [NCEDC FDSNWS](http://service.ncedc.org/).


## waveformArm

Those recipes contain all the three Arms, which are used to download seismic waveforms, including instrument responses (`poles and zeros` and/or `responses`), raw data (`seismograms-raw`), and seismic data with response remove (`seismograms`). You may revise, comment, or add some subsetters in the recipes according to your purposes. The recipes in the above `eventArm` and `networkArm` may be a starting reference.

- [recipe-csvEvent-fixedNet.xml](waveformArm/recipe-csvEvent-fixedNet.xml) : Query seismic waveforms from [IRIS-DMC FDSNWS](http://service.iris.edu/fdsnws/). The catalog (i.e., `events.csv`) is already downloaded using other mehtod, and the networks and stations are set explicitly. You can comment the `stationOR` subsetter so that all the stations in the networks will be downloaded instead.
- [recipe-csvEvent-fixedNet-phase.xml](waveformArm/recipe-csvEvent-fixedNet-phase.xml) : same as [recipe-csvEvent-fixedNet.xml](waveformArm/) except that a reference phase is used to limit the time window.
- [recipe-continous.xml](waveformArm/recipe-continous.xml) : Query continous seismic waveforms from [IRIS-DMC FDSNWS](http://service.iris.edu/fdsnws/). I set the output format to be miniseed. Please see the discussion in [SOD email list](https://groups.google.com/a/seis.sc.edu/forum/#!searchin/sod/fake$20event%7Csort:date/sod/lEz3WpG1XNk/hby7SSzGVGcJ).
- [recipe-IRISPH5.xml](waveformArm/recipe-IRISPH5.xml) : Query seismic waveforms from [IRIS-DMC's PH5 FDSNWS](http://service.iris.edu/ph5ws/). You need at least SOD 3.2.11 to use this recipe due to a bug in old version. A prerelease can be found [here](http://www.seis.sc.edu/downloads/sod/prerelease/3.2.11-SNAPSHOT/). It seems that it **DOES NOT** work now.
- [recipe-SC.xml](waveformArm/recipe-SC.xml)      : Query seismic waveforms from [Southern California Earthquake Data Center (SCEDC) FDSNWS](https://service.scedc.caltech.edu/)
- [recipe-NC.xml](waveformArm/recipe-NC.xml)      : Query seismic waveforms from [NCEDC FDSNWS](http://service.ncedc.org/)
- [recipe-GEOFON.xml](waveformArm/recipe-GEOFON.xml)  : Query seismic waveforms from [GEOFON FDSNWS](http://geofon.gfz-potsdam.de/fdsnws/).
- [recipe-ORFEUS.xml](waveformArm/recipe-ORFEUS.xml)  : Query seismic waveforms from [ORFEUS FDSNWS](http://www.orfeus-eu.org/fdsnws/)


## Subsetter Notes

### Data Servers

- The default of [fdsnEvent](http://www.seis.sc.edu/sod/ingredients/fdsnEvent.html) is to query [USGS FDSN Event web service](https://earthquake.usgs.gov/fdsnws/event/1/), i.e., [ANSS Comprehensive Earthquake Catalog (ComCat)](https://earthquake.usgs.gov/earthquakes/search/). You can also query other Data Center's Event web service (e.g., [IRIS-DMC Event web service](http://service.iris.edu/fdsnws/event/1)).
- The default of [fdsnStation](http://www.seis.sc.edu/sod/ingredients/fdsnStation.html) is to query [IRIS-DMC FDSN Station web service](http://service.iris.edu/fdsnws/station/1/). By default this does not get restricted channels unless there is a corresponding [fdsnDataSelect](http://www.seis.sc.edu/sod/ingredients/fdsnDataSelect.html) that has a `user` and `password` specified.
- The default of [fdsnDataSelect](http://www.seis.sc.edu/sod/ingredients/fdsnDataSelect.html) is to query [IRIS-DMC FDSN Dataselect web service](http://service.iris.edu/fdsnws/dataselect/1/). To query restricted data, set `user` and `password` in [fdsnDataSelect](http://www.seis.sc.edu/sod/ingredients/fdsnDataSelect.html). Please see the discussion in [SOD email list](https://groups.google.com/a/seis.sc.edu/forum/#!topic/sod/Rfi_LRr8dwE)
- To query at non-default Data Center, please refer to [FDSN web service](https://www.fdsn.org/webservices/) to see the supporting Data Centers and their hosts. Below are the host names for some Data Centers. Please see the discussion in [SOD email list](https://groups.google.com/a/seis.sc.edu/g/sod/c/7B0tWrEFeGQ).
    - [IRIS-DMC](http://service.iris.edu/fdsnws/) : `service.iris.edu`
    - [IRIS-DMC's PH5 web services](http://service.iris.edu/ph5ws/) : `service.iris.edu`
    - [SCEDC](https://service.scedc.caltech.edu/) : `service.scedc.caltech.edu`
    - [NCEDC](http://service.ncedc.org/) : `service.ncedc.org`
    - [GEOFON](http://geofon.gfz-potsdam.de/fdsnws/): `geofon.gfz-potsdam.de`
    - [ORFEUS](http://www.orfeus-eu.org/fdsnws/) : `www.orfeus-eu.org`
- If we'd like to use [IRIS-DMC's PH5 web services](http://service.iris.edu/ph5ws/), we have to set the path of fdsnws (i.e., `fdsnwsPath`) to be `ph5ws` in the [fdsnEvent](http://www.seis.sc.edu/sod/ingredients/fdsnEvent.html), [fdsnStation](http://www.seis.sc.edu/sod/ingredients/fdsnStation.html), and [fdsnDataSelect](http://www.seis.sc.edu/sod/ingredients/fdsnDataSelect.html) subsetters, although the name is `fdsnPath` in the `fdsnEvent` and `fdsnDataSelect` in the online SOD manual. Please check the discussion about this issue in the [SOD email list](https://groups.google.com/a/seis.sc.edu/forum/#!topic/sod/j-rxZxYj1jQ). However, I am not sure if the name is actually `fdsnPath` or `fdsnwsPath` in the `fdsnEvent` subsetter. Maybe you can try both, and report it in the [SOD email list](http://www.seis.sc.edu/sod/) if there exists a bug.

### eventChannel Subsetters

- I use the subsetter [bestChannelAtStation](http://www.seis.sc.edu/sod/ingredients/bestChannelAtStation.html) in [eventChannel](http://www.seis.sc.edu/sod/ingredients/eventChannel.html), but it is unfortunately fragile because stations often have unusual characteristics that keep it from working. We may miss some channels that actually have data. We may not use the subsetter and choose to download all the channels, while we can also use other subsetters within the [eventChannel](http://www.seis.sc.edu/sod/ingredients/eventChannel.html). In the later case, you have to know the channels you want. Please see the discussion about this issue in the [SOD email list](https://groups.google.com/a/seis.sc.edu/forum/#!topic/sod/pWgzAkaggw0).

### availableData Subsetters

- Before SOD asks the data center to send it data, we can use subsetter in [availableData](http://www.seis.sc.edu/sod/ingredients/availableData.html) to ask Data Center if it has data for the time range generated by the request generator. These tactics allow decisions to be made based on the server's response. The default is [fullCoverage](http://www.seis.sc.edu/sod/ingredients/fullCoverage.html). I usually use [someCoverage](http://www.seis.sc.edu/sod/ingredients/someCoverage.html) to accept data if it spans some of the generated request.

### seismogramProcess Subsetters

- [someDataCoverage](http://www.seis.sc.edu/sod/ingredients/someDataCoverage.html) checks the data returned from Data Center against the request generated by the request generator. If at least one piece of data exists during the time specified by the request generator, this processor passes the data onto the next step.
- [merge](http://www.seis.sc.edu/sod/ingredients/merge.html), [collapseOverlaps](http://www.seis.sc.edu/sod/ingredients/collapseOverlaps.html) and [gapFill](http://www.seis.sc.edu/sod/ingredients/gapFill.html) need to be carefully used. I usually use them in the above order. Be aware that `gapFill` and `merge` might shift later waveforms by up to 1/2 a sample interval in order to get the time basis aligned. Please check the disscussion in [SOD email list](https://groups.google.com/a/seis.sc.edu/g/sod/c/xbCzRkdk-_A).
    - `merge`: If the seismogram server is returning multiple continuous seismograms for a request, this will join them into a single seismogram. Continuous means that the begin time of the second seismogram is approximately one sample period after the end time of the first seismogram. This processor **DOES NOT** merge overlapping seismograms or seismograms where there is a gap larger than one sample period. For those cases see `collapseOverlaps` and `gapFill` respectively.
    - `collapseOverlaps`: it checks for overlapping seismograms. If one seismogram is completely contained in another seismogram, it is removed. If two seismograms overlap partially, then the longer of the two is kept in its entirety and the short is cut to no longer overlap This processor should ideally not be needed, as the server should refrain from returning overlapping data.
    - `gapFill`: If the seismogram server is returning multiple continuous seismograms for a request, this will join them into a single seismogram filling any gaps. This **IMPLICITYLY DOES** a `collapseOverlaps` and a `merge` before filling gaps.
- [noDataGaps](http://www.seis.sc.edu/sod/ingredients/noDataGaps.html) checks the data returned from Data Center for gaps larger than the sample period of the instrument. If from the begin time of the earliest piece to the end time of the latest piece there are no gaps in time larger than the sample period, this process passes the data onto the next item in the line.
- If you use SOD to do the [transferResponse](http://www.seis.sc.edu/sod/ingredients/transferResponse.html) process, it is necessary to further multiply the waveform by `1.0e9` to convert from meters to nanometers. Please refer to SAC's `transfer` reference to check the reason (see `POLEZERO OPTION`). You may also refer to some Chinese tutorials about this issue: [Chinese SAC manual](https://seisman.github.io/SAC_Docs_zh/commands/transfer/) and [Difference when doing transfer using RESP and PZ](https://blog.seisman.info/resp-sacpz-difference/). In addition, choose right arguments for `transferResponse`. For example, f4 should be smaller than Nyquist frequency (if sampling rate is 0.01 s, then Nyquist frequency is 50 Hz).
```bash
$ SAC
# see `POLEZERO OPTION`
$ help transfer
```


## Tests

Some tests I used to examine SOD subsetters and bugs.


## References

- If you'd like to know more about SOD, please refer to [SOD documentation](http://www.seis.sc.edu/sod/documentation/index.html) with [some tutorials of the major SOD aspects](http://www.seis.sc.edu/sod/documentation/tutorials/index.html). [A Chinese introduction](https://blog.seisman.info/sod-notes/) is also useful. You can also sign up [SOD email list](http://www.seis.sc.edu/sod/) for annoucements, discussions and questions about using SOD.
- If you'd like to use different subsetters in eventArm, networkArm, waveformArm (I have indicated the locations of some unused subsetters in those recipes), please refer to the following websites:
    - [SOD ingredients](http://www.seis.sc.edu/sod/ingredients/index.html)
    - [Seisman's SOD recipes](https://github.com/seisman/SODrecipes)

