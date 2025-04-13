(deftemplate Sintomas
  (slot ardencia_ao_urinar)
  (slot vontade_frequente_de_urinar)
  (slot urina_odor_forte)
  (slot dor_no_abdomen)
  (slot febre)
  (slot coceira)
  (slot corrimento_branco)
  (slot dor_na_relacao_sexual)
  (slot corrimento_acinzentado)
  (slot dor_no_baixo_ventre)
  (slot colicas)
  (slot fluxo_menstrual_intenso)
  (slot constipacao)
  (slot pressao_na_bexiga)
  (slot ciclo_irregular)
  (slot acne)
  (slot infertilidade))

(deftemplate Doenca
  (slot nome))

(deftemplate Tratamento
  (slot nome))

; Perguntar sintomas
(defrule get_ardencia_ao_urinar
  (declare (salience 9))
  =>
  (printout t "Você sente ardência ao urinar? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (ardencia_ao_urinar ?resposta))))

(defrule get_vontade_frequente_de_urinar
  (declare (salience 9))
  =>
  (printout t "Você sente vontade frequente de urinar? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (vontade_frequente_de_urinar ?resposta))))

(defrule get_urina_odor_forte
  (declare (salience 9))
  =>
  (printout t "Você tem urina com odor forte? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (urina_odor_forte ?resposta))))

(defrule get_dor_no_abdomen
  (declare (salience 9))
  =>
  (printout t "Você tem dor no abdômen? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (dor_no_abdomen ?resposta))))

(defrule get_febre
  (declare (salience 9))
  =>
  (printout t "Você tem febre? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (febre ?resposta))))

(defrule get_coceira
  (declare (salience 9))
  =>
  (printout t "Você tem coceira na região íntima? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (coceira ?resposta))))

(defrule get_corrimento_branco
  (declare (salience 9))
  =>
  (printout t "Você está com corrimento branco? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (corrimento_branco ?resposta))))

(defrule get_dor_na_relacao_sexual
  (declare (salience 9))
  =>
  (printout t "Você sente dor na relação sexual? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (dor_na_relacao_sexual ?resposta))))

(defrule get_corrimento_acinzentado
  (declare (salience 9))
  =>
  (printout t "Você está com corrimento acinzentado? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (corrimento_acinzentado ?resposta))))

(defrule get_dor_no_baixo_ventre
  (declare (salience 9))
  =>
  (printout t "Você sente dor no baixo ventre? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (dor_no_baixo_ventre ?resposta))))

(defrule get_colicas
  (declare (salience 9))
  =>
  (printout t "Você está com colicas? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (colicas ?resposta))))

(defrule get_fluxo_menstrual_intenso
  (declare (salience 9))
  =>
  (printout t "Você tem notado seu fluxo menstrual intenso? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (fluxo_menstrual_intenso ?resposta))))

(defrule get_constipacao
  (declare (salience 9))
  =>
  (printout t "Você tem constipação? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (constipacao ?resposta))))

(defrule get_pressao_na_bexiga
  (declare (salience 9))
  =>
  (printout t "Você tem pressao_na_bexiga? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (pressao_na_bexiga ?resposta))))

(defrule get_ciclo_irregular
  (declare (salience 9))
  =>
  (printout t "Você tem notado ciclo menstrual irregular? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (ciclo_irregular ?resposta))))

(defrule get_acne
  (declare (salience 9))
  =>
  (printout t "Você tem acne? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (acne ?resposta))))

(defrule get_infertilidade
  (declare (salience 9))
  =>
  (printout t "Você tem infertilidade? (sim/nao)" crlf)
  (bind ?resposta (read))
  (assert (Sintomas (infertilidade ?resposta))))


; Regras para diagnóstico de doenças e tratamento
(defrule diagnostico_infeccao_urinaria
  (and (Sintomas (ardencia_ao_urinar sim))
       (Sintomas (vontade_frequente_de_urinar sim))
       (Sintomas (urina_odor_forte sim))
       (Sintomas (dor_no_abdomen sim)))
  =>
  (assert (Doenca (nome "Infecção urinária")))
  (assert (Tratamento (nome "A folha de goiabeira, tanchagem, açafrão e o dente de leão ajudam no tratamento da infecção urinária. Métodos recomendados: chá quente de tanchagem e açafrão, banho de assento com infusão de folha de goiabeira e dente de leão.")))
  (printout t "Diagnóstico: Infecção urinária. Tratamento sugerido: A folha de goiabeira, tanchagem, açafrão e o dente de leão ajudam no tratamento da infecção urinária. Métodos recomendados: chá quente de tanchagem e açafrão, banho de assento com infusão de folha de goiabeira e dente de leão." crlf))

(defrule diagnostico_candidiase_vaginal
  (and (Sintomas (ardencia_ao_urinar sim))
       (Sintomas (coceira sim))
       (Sintomas (corrimento_branco sim))
       (Sintomas (dor_na_relacao_sexual sim)))
  =>
  (assert (Doenca (nome "Candidíase vaginal")))
  (assert (Tratamento (nome "A folha de goiabeira, lavanda, açafrão e tanchagem ajudam no tratamento da candidíase vaginal. Métodos recomendados: banho de assento com infusão de folha de goiabeira ou lavanda; compressas; chá de lavanda; açafrão e tanchagem.")))
  (printout t "Diagnóstico: Candidíase vaginal. Tratamento sugerido: A folha de goiabeira, lavanda, açafrão e tanchagem ajudam no tratamento da candidíase vaginal. Métodos recomendados: banho de assento com infusão de folha de goiabeira ou lavanda; compressas; chá de lavanda; açafrão e tanchagem." crlf))

(defrule diagnostico_vaginose_bacteriana
  (and (Sintomas (urina_odor_forte sim))
       (Sintomas (coceira sim))
	   (Sintomas (corrimento_acinzentado sim)))
  =>
  (assert (Doenca (nome "Vaginose bacteriana")))
  (assert (Tratamento (nome "A folha de goiabeira e lavanda ajudam no tratamento da vaginose bacteriana. Métodos recomendados: banho de assento com folha de goiabeira e lavanda; compressas com infusão morna.")))
  (printout t "Diagnóstico: Vaginose bacteriana. Tratamento sugerido: A folha de goiabeira e lavanda ajudam no tratamento da vaginose bacteriana. Métodos recomendados: banho de assento com folha de goiabeira e lavanda; compressas com infusão morna." crlf))

(defrule diagnostico_cistite
  (and (Sintomas (ardencia_ao_urinar sim))
       (Sintomas (vontade_frequente_de_urinar sim))
	   (Sintomas (dor_no_baixo_ventre sim)))
  =>
  (assert (Doenca (nome "Cistite")))
  (assert (Tratamento (nome "A tanchagem, a folha de goiabaiera e o dente de leão ajudam no tratamento da cistite. Métodos recomendados: chá quente de tanchagem e dente de leão; banho de assento com folha de goiabeira.")))
  (printout t "Diagnóstico: Cistite. Tratamento sugerido: A tanchagem, a folha de goiabaiera e o dente de leão ajudam no tratamento da cistite. Métodos recomendados: chá quente de tanchagem e dente de leão; banho de assento com folha de goiabeira." crlf))

(defrule diagnostico_sop
  (and (Sintomas (ciclo_irregular sim))
       (Sintomas (acne sim))
	   (Sintomas (infertilidade sim)))
  =>
  (assert (Doenca (nome "Síndrome do Ovário Policístico (SOP)")))
  (assert (Tratamento (nome "A folha de amora e sálvia ajudam no tratamento da SOP. Métodos recomendados: chá de folha de amora e sálvia; banho de assento com sálvia.")))
  (printout t "Diagnóstico: Síndrome do Ovário Policístico (SOP). Tratamento sugerido: A folha de amora e sálvia ajudam no tratamento da SOP. Métodos recomendados: chá de folha de amora e sálvia; banho de assento com sálvia." crlf))

(defrule diagnostico_miomas
  (and (Sintomas (colicas sim))
       (Sintomas (fluxo_menstrual_intenso sim))
       (Sintomas (pressao_na_bexiga sim))
	   (Sintomas (constipacao sim)))
  =>
  (assert (Doenca (nome "Miomas")))
  (assert (Tratamento (nome "A folha de amora, artemísia, camomila e sálvia ajudam no tratamento de miomas. Métodos recomendados: chá de folha de amora, camomila e artemísia; banho de assento com camomila ou folha de amora; sálvia.")))
  (printout t "Diagnóstico: Miomas. Tratamento sugerido: A folha de amora, artemísia, camomila e sálvia ajudam no tratamento de miomas. Métodos recomendados: chá de folha de amora, camomila e artemísia; banho de assento com camomila ou folha de amora; sálvia." crlf))

(defrule diagnostico_endometriose
  (and (Sintomas (dor_na_relacao_sexual sim))
       (Sintomas (colicas sim))
	   (Sintomas (infertilidade sim)))
  =>
  (assert (Doenca (nome "Endometriose")))
  (assert (Tratamento (nome "A folha de amora, camomila, lavanda e o dente de leão ajudam no tratamento da endometriose. Métodos recomendados: chá de folha de amora, camomila elavanda; banho de assento com camomila ou lavanda; compressas mornas na região pélvica; dente de leão.")))
  (printout t "Diagnóstico: Endometriose. Tratamento sugerido: A folha de amora, camomila, lavanda e o dente de leão ajudam no tratamento da endometriose. Métodos recomendados: chá de folha de amora, camomila elavanda; banho de assento com camomila ou lavanda; compressas mornas na região pélvica; dente de leão." crlf))

; Exibir resultado final
(defrule Fim
  (Doenca (nome ?doenca))
  (Tratamento (nome ?tratamento))
  =>
  (printout t crlf crlf)
  (printout t "A doença identificada é: " ?doenca crlf)
  (printout t "Tratamento: " ?tratamento crlf))

(defrule Titulo
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Sistema Especialista em Ginecologia Natural - Diagnóstico de Doenças e Tratamento" crlf crlf))
