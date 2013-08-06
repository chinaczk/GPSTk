///////////////////////////////////////////////
//              Python stuff
///////////////////////////////////////////////
%pythoncode %{
def now():
    """Returns the current time (defined by what SystemTime() returns)
    in a CommonTime format, in the given TimeSystem.

    Parameters:
            -----------

        timeSystem:  the TimeSystem (enum value) to assign to the output
    """
    return SystemTime().toCommonTime()

%}

///////////////////////////////////////////////
//      Macros for string (__str__) stuff
///////////////////////////////////////////////
// Uses the dump method in the class to get string output
%define STR_DUMP_HELPER(name)
%extend gpstk:: ## name {
     std::string __str__() {
        std::ostringstream stream;
        $self->dump(stream);
        return stream.str();
    }
}
%enddef
STR_DUMP_HELPER(AlmOrbit)
STR_DUMP_HELPER(BrcClockCorrection)
STR_DUMP_HELPER(BrcKeplerOrbit)
STR_DUMP_HELPER(EngAlmanac)
STR_DUMP_HELPER(EngEphemeris)
STR_DUMP_HELPER(FICData)
STR_DUMP_HELPER(FICHeader)
STR_DUMP_HELPER(GalEphemeris)
STR_DUMP_HELPER(GalEphemerisStore)
STR_DUMP_HELPER(GloEphemeris)
STR_DUMP_HELPER(GPSEphemerisStore)
STR_DUMP_HELPER(OrbElem)
STR_DUMP_HELPER(OrbElemStore)
STR_DUMP_HELPER(Rinex3ClockData)
STR_DUMP_HELPER(Rinex3ClockHeader)
STR_DUMP_HELPER(Rinex3EphemerisStore)
STR_DUMP_HELPER(Rinex3NavData)
STR_DUMP_HELPER(Rinex3NavHeader)
STR_DUMP_HELPER(Rinex3ObsData)
STR_DUMP_HELPER(Rinex3ObsHeader)
STR_DUMP_HELPER(RinexMetData)
STR_DUMP_HELPER(RinexMetHeader)
STR_DUMP_HELPER(RinexNavData)
STR_DUMP_HELPER(RinexNavHeader)
STR_DUMP_HELPER(RinexObsData)
STR_DUMP_HELPER(RinexObsHeader)
STR_DUMP_HELPER(RinexSatID)
STR_DUMP_HELPER(SEMData)
STR_DUMP_HELPER(SEMHeader)
STR_DUMP_HELPER(SP3Data)
STR_DUMP_HELPER(SP3EphemerisStore)
STR_DUMP_HELPER(SP3Header)
STR_DUMP_HELPER(SP3SatID)
STR_DUMP_HELPER(YumaData)
STR_DUMP_HELPER(YumaHeader)



// Uses the operator<< in the class to get string output
%define STR_STREAM_HELPER(name)
%extend gpstk:: ##name {
    std::string __str__() {
        std::ostringstream stream;
        stream << *($self);
        return stream.str();
    }
}
%enddef
STR_STREAM_HELPER(ReferenceFrame)
STR_STREAM_HELPER(Xv)

// STR_STREAM_HELPER(Xvt)
// Q: Why is this (below) here instead of the macro for Xvt?
// A: There is an ambiguity issue for the operator<< for Xvt,
// see the end of TabularSatStore.hpp for a conflicting defintion
// of the Xvt out stream operator and Xvt.hpp+Xvt.cpp.
%extend gpstk::Xvt {
   std::string __str__() {
      std::ostringstream os;
         os << "x:" << $self->x
            << ", v:" << $self->v
            << ", clk bias:" << $self->clkbias
            << ", clk drift:" << $self->clkdrift
            << ", relcorr:" << $self->relcorr;
      return os.str();
   }
}




// Uses gpstk::StringUtils::asString(x) to get string output
%define AS_STRING_HELPER(name)
%extend gpstk:: ##name {
    std::string __str__() {
        return gpstk::StringUtils::asString(*($self));
    }
}
%enddef
AS_STRING_HELPER(ObsID)
AS_STRING_HELPER(SatID)