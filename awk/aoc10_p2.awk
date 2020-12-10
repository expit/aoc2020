#!/usr/bin/awk -f
# listadd creates sorted list,
# every element points at the next element
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
  n=1 # number of permutations
  p=0 # consecutive numbers of elements that differs by one
  for(i=0;i<last;){
    p++ # increment number of consecutive numbers

    # different combinations are possible only if elements differ by 1
    if(a[i]-i==3){
      # Element can be removed only when element before and after have joltage differences of 1 or 2
      # if the sequence of consecutive numbers that differs by 1 is:
      # 2 then no element can be removed
      # 3 or 4, then any the elements in the middle can be removed
      if (p==4||p==3 ){
        n*=2^(p-2)
      }
      # for sequences longer than 5 there is a risk of creating difference of more than 3 jolts
      # (binary representation of elements (removed marked as 1)
      # 00000
      # 00010
      # 00100
      # 00110
      # 01000
      # 01010
      # 01100
      # 01110  # this situation will create difference in joltage of 4
      # 
      # math formula to count 3 and more consecutive numbers in subset is 3^x - 3^(x-1) + 1
      # where x+1 is number of elements suitable to be removed
      if (p>4){
  	n*=3^(p-3)-3^(p-4)+1
      }
    p=0
    }
    i=a[i]
  }
  print "part 1: " b[1]*b[3]
  print "part 2: " n
}
