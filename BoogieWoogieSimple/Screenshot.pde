void startRecording() {
  if (!javascriptRunnning) {
    int[] elements = { day(),month(),year(),hour(),minute(),second() };
    String file = join(nf(elements, 0),"-") + ".pdf";
    beginRecord(PDF, "screenshots/" + file);
  }
}

void stopRecording() {
   if (!javascriptRunnning) {
     endRecord();
   } 
}


