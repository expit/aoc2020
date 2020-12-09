#!/usr/bin/awk -f

BEGIN{
  RS="[[:space:]]"
  preamble=25
}

NR<=preamble{
  n[NR%preamble]=$0
  if(NR==preamble){
    for(i=0;i<preamble;i++){
      for (j=(i+1);j<preamble;j++){
        sums[i SUBSEP j]=n[i]+n[j]
	valid[sums[i SUBSEP j]]++
      }
    }
  }
  next
}
{
  if(!valid[$0]){
	  print $0
	  exit
  } else {
    delta=$0-n[NR%preamble]
    n[NR%preamble]=$0
    for(i=0;i<preamble;i++){
      if(i!=NR%preamble){
        if(i<NR%preamble){
          id=i SUBSEP (NR%preamble)
        } else {
          id=(NR%preamble) SUBSEP i
        }
        valid[sums[id]]--

        sums[id]=sums[id]+delta
        valid[sums[id]]++
      }
    }
  }

}
