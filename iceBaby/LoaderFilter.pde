/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  searching for files & filter them based on their type - this is not a class, these are some native java functions for file handling
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//  filter out files that are not .pngs

// ---  loosers folder

String[] fileNames;
java.io.FilenameFilter txtFilter = new java.io.FilenameFilter() 
{
  boolean accept(File dir, String name) 
  {
    return name.toLowerCase().endsWith(".png");
  }
};
  
String[] listFileNames(String dir,java.io.FilenameFilter extension) 
{
  File file = new File(dir);
  if (file.isDirectory()) 
  {
    String names[] = file.list(extension);
    return names;
  } 
  else {
    return null;
  }
}

// ---  winners folder

String[] winnerfileNames;

java.io.FilenameFilter winnertxtFilter = new java.io.FilenameFilter() 
{
  boolean accept(File winnerdir, String name) 
  {
    return name.toLowerCase().endsWith(".png");
  }
};

String[] listwinnerFileNames(String dir,java.io.FilenameFilter extension) 
{
  File file = new File(dir);
  if (file.isDirectory()) 
  {
    String names[] = file.list(extension);
    return names;
  } 
  else {
    return null;
  }
}


