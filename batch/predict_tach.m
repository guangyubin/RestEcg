function label = predict_tach(X)

Mdl7 = loadCompactModel ('Md17_tach');
label = predict(Mdl7,X);