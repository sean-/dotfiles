# Use .enter.local.tcsh to provide settings that are specific to your local environment
if (-o .enter.local.tcsh && -P22: .enter.local.tcsh == "0") source .enter.local.tcsh

if ( ${?BOOST_INCDIR} == "0" ) then
        setenv BOOST_INCDIR $HOME/src/boost-trunk
        printf '[INFO] Setting BOOST_INCDIR environment variable to %s\n' ${BOOST_INCDIR}
endif

if ( ${?BOOST_LIBDIR} == "0" ) then
        setenv BOOST_LIBDIR $HOME/src/boost-trunk/lib
        printf '[INFO] Setting BOOST_LIBDIR environment variable to %s\n' ${BOOST_LIBDIR}
endif
