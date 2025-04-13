% Doenças
doenca('Infeccao urinaria').
doenca('Candidiase vaginal').
doenca('Vaginose bacteriana').
doenca('Cistite').
doenca('SOP').
doenca('Miomas').
doenca('Endometriose').

% Sintomas
sintoma('Ardencia ao urinar').
sintoma('Vontade frequente de urinar').
sintoma('Urina odor forte').
sintoma('Dor no abdomen').
sintoma('Febre').
sintoma('Coceira').
sintoma('Corrimento branco').
sintoma('Dor na relacao sexual').
sintoma('Corrimento acinzentado').
sintoma('Dor no baixo ventre').
sintoma('Colicas').
sintoma('Fluxo menstrual intenso').
sintoma('Constipacao').
sintoma('Pressao na bexiga').
sintoma('Ciclo irregular').
sintoma('Acne').
sintoma('Infertilidade').

% Tratamentos naturais
tratamento('Folha de goiabeira').
tratamento('Folha de amora').
tratamento('Artemisia').
tratamento('Lavanda').
tratamento('Acafrao').
tratamento('Tanchagem').
tratamento('Camomila').
tratamento('Salvia').
tratamento('Dente de leao').

% Sintomas por doença
sintomas_da_doenca('Infeccao urinaria', ['Ardencia ao urinar', 'Vontade frequente de urinar', 'Urina odor forte', 'Dor no abdomen', 'Febre']).
sintomas_da_doenca('Candidiase vaginal', ['Ardencia ao urinar', 'Coceira', 'Corrimento branco', 'Dor na relacao sexual']).
sintomas_da_doenca('Vaginose bacteriana', ['Urina odor forte', 'Corrimento acinzentado']).
sintomas_da_doenca('Cistite', ['Ardencia ao urinar', 'Vontade frequente de urinar', 'Dor no baixo ventre']).
sintomas_da_doenca('SOP', ['Ciclo irregular', 'Acne', 'Infertilidade']).
sintomas_da_doenca('Miomas', ['Colicas', 'Fluxo menstrual intenso', 'Constipacao', 'Pressao na bexiga']).
sintomas_da_doenca('Endometriose', ['Dor na relacao sexual', 'Colicas', 'Infertilidade']).

% Tratamentos naturais por doença
tratamento_da_doenca('Infeccao urinaria', ['Folha de goiabeira', 'Lavanda', 'Acafrao', 'Tanchagem', 'Dente de leao']).
tratamento_da_doenca('Candidiase vaginal', ['Folha de goiabeira', 'Lavanda', 'Acafrao', 'Tanchagem']).
tratamento_da_doenca('Vaginose bacteriana', ['Folha de goiabeira', 'Lavanda']).
tratamento_da_doenca('Cistite', ['Folha de goiabeira', 'Tanchagem', 'Dente de leao']).
tratamento_da_doenca('SOP', ['Folha de amora', 'Salvia']).
tratamento_da_doenca('Miomas', ['Folha de amora', 'Artemisia', 'Camomila', 'Salvia']).
tratamento_da_doenca('Endometriose', ['Folha de amora', 'Camomila', 'Dente de leao']).

% Predicado principal (main/0)
main :-
    % Faz a consulta para encontrar sintomas e tratamentos
    sintomas_da_doenca(Doenca, Sintomas),
    member('Ardencia ao urinar', Sintomas),
    member('Vontade frequente de urinar', Sintomas),
    tratamento_da_doenca(Doenca, Tratamentos),
    write('Doença: '), write(Doenca), nl,
    write('Tratamentos sugeridos: '), write(Tratamentos), nl,
    fail.  % Para continuar buscando mais soluções
main.
