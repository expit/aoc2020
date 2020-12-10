#!/usr/bin/awk -f
func listadd(new,old,   tmp){
  tmp=a[old]
  a[old]=new
  a[new]=tmp
  if(last==old) last=new
}

BEGIN{
  a[0]="0";
  last=0
}
{
  # check if preceeding adapter exists
  if(a[$0-1]){ listadd($0,$0-1); next}
  if(a[$0-2]){ listadd($0,$0-2); next}
  if(a[$0-3]){ listadd($0,$0-3); next}
  if(last<$0){ listadd($0,last); next}
  # add adaper on correct positon
  for(i=0;i<last;){
    if(a[i] > $0){
      listadd($0, i)
      break;
    }
    i=a[i]
  }
}
END{
  listadd(last+3,last)
  
  for(i=0;i<last;){
	  #print i,a[i],a[i]-i;
	  b[a[i]-i]++
	  i=a[i]
  }
  for(i in b){
	  print i,b[i]
  }
  print b[1]*b[3]
}
