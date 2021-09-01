#' Title
#'
#' @param model_input
#'
#' @return Returns a list of results
#' @export
#'
#' @examples
model_run<-function(model_input = NULL)
{

  input<-unflatten_list(model_input)

  results <- plcom2012         (age                        =model_input$age,
                                race                       =model_input$race,
                                education                  =model_input$education,
                                bmi                        =model_input$bmi,
                                copd                       =model_input$copd,
                                cancer_hist                =model_input$cancer_hist,
                                family_hist_lung_cancer    =model_input$family_hist_lung_cancer,
                                smoking_status             =model_input$smoking_status,
                                smoking_intensity          =model_input$smoking_intensity,
                                duration_smoking           =model_input$duration_smoking,
                                smoking_quit_time          =model_input$smoking_quit_time)

  return(as.list(results))
}


prism_get_default_input <- function() {
  model_input <- list(age                                  =62,
                      race                                 =1,
                      education                            =4,
                      bmi                                  =27,
                      copd                                 =0,
                      cancer_hist                          =0,
                      family_hist_lung_cancer              =0,
                      smoking_status                       =0,
                      smoking_intensity                    =80,
                      duration_smoking                     =27,
                      smoking_quit_time                    =10 )
  return((flatten_list(model_input)))
}


#Gets a hierarchical named list and flattens it; updating names accordingly
flatten_list<-function(lst,prefix="")
{
  if(is.null(lst)) return(lst)
  out<-list()
  if(length(lst)==0)
  {
    out[prefix]<-NULL
    return(out)
  }

  for(i in 1:length(lst))
  {
    nm<-names(lst[i])

    message(nm)

    if(prefix!="")  nm<-paste(prefix,nm,sep=".")

    if(is.list(lst[[i]]))
      out<-c(out,flatten_list(lst[[i]],nm))
    else
    {
      out[nm]<-lst[i]
    }
  }
  return(out)
}



#Gets a hierarchical named list and flattens it; updating names accordingly
unflatten_list<-function(lst)
{
  if(is.null(lst)) return(lst)
  out<-list()

  nms<-names(lst)

  for(nm in nms)
  {
    path<-paste(strsplit(nm,'.',fixed=T)[[1]],sep="$")
    eval(parse(text=paste("out$",paste(path,collapse="$"),"<-lst[[nm]]",sep="")))
  }

  return(out)
}
