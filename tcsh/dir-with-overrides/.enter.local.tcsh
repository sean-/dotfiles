if ( ${?BOOST_INCDIR} == "0" ) then
        setenv BOOST_INCDIR $HOME/src/boost/obj/contrib-Darwin-i386/include
        printf '[INFO] Setting BOOST_INCDIR environment variable to %s\n' ${BOOST_INCDIR}
endif

if ( ${?BOOST_LIBDIR} == "0" ) then
        setenv BOOST_LIBDIR $HOME/src/boost/obj/contrib-Darwin-i386/lib
        printf '[INFO] Setting BOOST_LIBDIR environment variable to %s\n' ${BOOST_LIBDIR}
endif

if ( ${?DYLD_FALLBACK_LIBRARY_PATH} == "0" ) then
        setenv DYLD_FALLBACK_LIBRARY_PATH $HOME/src/boost/obj/contrib-Darwin-i386/lib
        printf '[INFO] Setting DYLD_FALLBACK_LIBRARY_PATH environment variable to %s\n' ${DYLD_FALLBACK_LIBRARY_PATH}
endif
