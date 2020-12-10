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
  #part 1
  for(i=0;i<last;){
    b[a[i]-i]++
    i=a[i]
  }

  #part 2
  n=1
  p=0
  for(i=0;i<last;){
    if(a[i]-i==1){
      p++
    }
    if(a[i]-i==3){
      p++
      if(p<3){
        n*=1
      } else {
        if (p<5){
          n*=2^(p-2)
        }
        if (p>4){
  	  n*=3^(p-3)-3^(p-4)+1
        }
      }
      p=0
    }
    i=a[i]
  }
  print "part 1: " b[1]*b[3]
  print "part 2: " n
}
