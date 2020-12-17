subStringBydii(String str , int end) => str.length >= end ? str.substring(0,end)+'...' : str;
subStringBydiiDejaScan(String str , int end) => str.length >= end ? str.substring(0,end)+'\n...' : str;