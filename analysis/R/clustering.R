#### attempts to scale

clusterable.df <- data.frame(dem.completes.df$TYPE4CLASS.dum, 
                             dem.completes.df$PAYSELF.dum, 
                             dem.completes.df$PAYPRIV.dum, 
                             dem.completes.df$HISPANIC.dum, 
                             dem.completes.df$WHITE.dum, 
                             dem.completes.df$BLACK.dum, 
                             dem.completes.df$ASIAN.dum, 
                             dem.completes.df$TWOPLUS.dum, 
                             dem.completes.df$SEX.dum, 
                             dem.completes.df$RURAL.dum, 
                             dem.completes.df$WEALTHY.dum)

#names(df)[names(df) == 'old.var.name'] <- 'new.var.name'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.TYPE4CLASS.dum'] <- 'TYPE4CLASS.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.PAYSELF.dum'] <- 'PAYSELF.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.PAYPRIV.dum'] <- 'PAYPRIV.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.HISPANIC.dum'] <- 'HISPANIC.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.WHITE.dum'] <- 'WHITE.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.BLACK.dum'] <- 'BLACK.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.ASIAN.dum'] <- 'ASIAN.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.TWOPLUS.dum'] <- 'TWOPLUS.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.SEX.dum'] <- 'SEX.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.RURAL.dum'] <- 'RURAL.dum'
names(clusterable.df)[names(clusterable.df) == 'dem.completes.df.WEALTHY.dum'] <- 'WEALTHY.dum'





clusterable.matrix <- scale(clusterable.df)




