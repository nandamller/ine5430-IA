import numpy as np
import pygad
import matplotlib.pyplot as plt

# Estado final desejado (o 0 representa o espaço vazio)
goal_state = np.array([[1, 2, 3],
                       [4, 5, 6],
                       [7, 8, 0]])

# Estado inicial embaralhado (exemplo)
initial_state = np.array([[3, 4, 1],
                          [2, 0, 8],
                          [6, 5, 7]])

# Movimento: 0=up, 1=down, 2=left, 3=right
directions = {
    0: (-1, 0),  # up
    1: (1, 0),   # down
    2: (0, -1),  # left
    3: (0, 1)    # right
}

# Encontra a posição do 0 e tenta movê-lo na direção dada (se for válido) e retorna o novo estado após o movimento
# Exemplo:
# Se receber:    
#   state = [[1, 2, 3],
#            [4, 0, 6],
#            [7, 5, 8]]
#   direction = 1 (down)
# Retorna:
#   new_state = [[1, 2, 3],
#                [4, 5, 6],
#                [7, 0, 8]]
def move_zero(state, direction):
    """
    Move o zero (espaço vazio) no jogo para uma nova posição com base na direção fornecida.

    Args:
        state (numpy.ndarray): Um array numpy 3x3 representando o estado atual do quebra-cabeça.
                               O valor 0 representa o espaço vazio.
        direction (int): A direção para mover o zero. Deve ser uma chave no dicionário `directions`,
                         onde cada chave mapeia para uma tupla representando a mudança nas coordenadas (dx, dy).

    Returns:
        numpy.ndarray: Um novo array numpy 3x3 representando o estado do quebra-cabeça após mover o zero.
                       Se o movimento for inválido (fora dos limites), o estado original é retornado inalterado.

    Nota:
        - O dicionário `directions` deve estar definido no escopo onde esta função é usada.
          Ele deve mapear inteiros (e.g., 0, 1, 2, 3) para mudanças de coordenadas.
        - A função assume que o estado de entrada contém exatamente um zero.
    """
    new_state = state.copy()
    x, y = np.argwhere(state == 0)[0]
    dx, dy = directions[direction]
    new_x, new_y = x + dx, y + dy
    if 0 <= new_x < 3 and 0 <= new_y < 3:
        new_state[x, y], new_state[new_x, new_y] = new_state[new_x, new_y], new_state[x, y]
    return new_state

def fitness_func(ga_instance, solution, solution_idx):
    """
    Calcula o fitness de uma solução para o problema do 8-puzzle.
    O fitness é determinado pela distância de Manhattan negativa entre o 
    estado atual (após aplicar os movimentos da solução) e o estado objetivo.
    Uma distância menor corresponde a um valor de fitness maior.
    Args:
        solution (list): Uma lista de movimentos representando a solução. Cada movimento 
                         especifica a direção para mover o espaço vazio (zero).
        solution_idx (int): O índice da solução na população atual. Não é usado nesta função.
    Returns:
        int: O valor de fitness da solução. Um valor maior (menos negativo) 
             indica uma solução melhor.
    """
    state = initial_state.copy()
    for move in solution:
        state = move_zero(state, move)
    
    dist = 0
    for num in range(1, 9):
        goal_pos = np.argwhere(goal_state == num)[0]
        curr_pos = np.argwhere(state == num)[0]
        dist += abs(goal_pos[0] - curr_pos[0]) + abs(goal_pos[1] - curr_pos[1])
    
    return -dist  # quanto menor a distância, maior o fitness

# GA config
gene_space = [0, 1, 2, 3]

ga_instance = pygad.GA(
    num_generations=100,
    num_parents_mating=10,
    sol_per_pop=50,
    num_genes=30,
    gene_space=gene_space,
    fitness_func=fitness_func,
    parent_selection_type="tournament",
    crossover_type="single_point",
    mutation_type="random",
    mutation_percent_genes=10,
    gene_type=int,
    stop_criteria=["reach_0"]  # Parar se fitness = 0 (solução perfeita)
)

ga_instance.run()
ga_instance.plot_fitness()

# Resultados
solution, solution_fitness, _ = ga_instance.best_solution()
print("\nMelhor sequência de movimentos (0=↑, 1=↓, 2=←, 3=→):", solution)
print("Fitness:", solution_fitness)

# Estado final obtido
state = initial_state.copy()
for move in solution:
    state = move_zero(state, move)
print("Estado final obtido:\n", state)