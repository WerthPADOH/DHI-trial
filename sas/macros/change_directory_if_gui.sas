 /*----------------------------------------------------------------------------
If run from a GUI (not batch), changes the system's working directory to that
of the program. Afterwards, file paths can be written relative to the new
directory.
 ----------------------------------------------------------------------------*/
%MACRO change_directory_if_gui;
    /* Get the filepath if running from SAS EG */
    %Let execpath = %sysfunc(dequote(&_SASPROGRAMFILE.));
    /* Get the filepath if running from base SAS */
    %If %length(&execpath.) = 0 %then
        %Let execpath = %sysget(SAS_EXECFILEPATH);
    %If %length(&execpath.) > 0 %then %do;
        %Let execname = %scan(&execpath., -1, \/);
        %Let execdir_length = %eval(%length(&execpath.) - %length(&execname.) - 1);
        %Let execdir = %substr(&execpath., 1, &execdir_length.);
        DATA _NULL_;
            rc = system("cd ""&execdir.""");
        Run;

        %Put Current directory changed to "&execdir.";
    %End;
%Mend change_directory_if_gui;
