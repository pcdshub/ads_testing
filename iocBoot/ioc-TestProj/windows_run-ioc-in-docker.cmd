@echo off
echo Your development environment Net ID is: 172.21.148.192.1.1
echo.
echo You must fully exit TwinCAT for this IOC to work.
echo Please close TwinCAT now and
pause
echo on

"C:/Program Files/Docker/Docker/resources/bin/docker.exe" run ^
        -v "c:\Repos\ads-deploy\tools\:/ads-deploy/tools" ^
        -v "C:\Users\awallace\Documents\Source\ADS_Testing\\:/reg/g/pcds/epics/ioc/ADS_Testing" ^
	-e DISPLAY=host.docker.internal:0.0 ^
	-i pcdshub/ads-deploy:latest ^
        "make -C ${ADS_IOC_PATH}/iocBoot/templates && cd '/reg/g/pcds/epics/ioc/ADS_Testing/iocBoot/ioc-TestProj' && make && sed -i '/^adsIoc_registerRecord.*$/a adsSetLocalAddress(172.21.148.192.1.1)' st.cmd && ./st.cmd; echo 'IOC exited.'; sleep 1"
pause
