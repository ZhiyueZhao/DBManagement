---- Oracle Catalog Extract Utility V1.0 ----                                   
----                                                                            
---- Run on MAR 22, 2016 at 11:51                                               
----                                                                            
--   Start extracting table ORDERS                                              
CREATE TABLE ORDERS (                                                           
   ORDERNUM                                                                     
 , ORDERCHAR                                                                    
 , CUST                                                                         
 , REP                                                                          
 , MANUF                                                                        
 , PROD                                                                         
 , QTY                                                                          
 , AMOUNT                                                                       
                    ); -- END of Table ORDERS creation                          
--                                                                              
--                                                                              
--   Start extracting table PRODUCTS                                            
CREATE TABLE PRODUCTS (                                                         
   MFR                                                                          
 , PRODUCT                                                                      
 , DESCRIPTION                                                                  
 , PRICE                                                                        
 , QTYONHAND                                                                    
                      ); -- END of Table PRODUCTS creation                      
--                                                                              
--                                                                              
---- Oracle Catalog Extract Utility V1.0 ----                                   
---- Run Completed on MAR 22, 2016 at 11:51                                     
