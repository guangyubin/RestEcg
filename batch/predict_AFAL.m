function label = predict_AFAL(X)

Mdl7 = loadCompactModel ('Md17_AV_AF');
label = predict(Mdl7,X);