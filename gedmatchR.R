rm(list=ls())
library(RCurl)
library(stringr)

getCredentials <- function(){
    email <- readline("Enter login email for gedmatch")  
    password <- readline("Enter password for gedmatch (warning! not encrypted!")

    
    return(list(email, password))
    
}

cred <- getCredentials()
email <- cred[[1]]
password <- cred[[2]]

handle <- getCurlHandle(useragent = str_c(R.version$platform,
                                          R.version$version.string,
                                          sep = ","),
                        httpheader = c(from = email),
                        followlocation = TRUE,
                        cookiefile = "")

getURL(url = "http://v2.gedmatch.com/login1.php", curl = handle)
cat(postForm("http://v2.gedmatch.com/login2.php", curl=handle,
             .params=c(email=email, password=password),
             style = "post", .opts = list(referer = "http://v2.gedmatch.com/login1.php")))
getURL('http://v2.gedmatch.com/r-list1z.php', curl = handle)
matchTable <- getForm('http://v2.gedmatch.com/r-list2z.php', kit_num='FB65328', cm_limit = 15, curl = handle)
library(RHTMLForms)
myform <- getHTMLFormDescription(matchTable)
