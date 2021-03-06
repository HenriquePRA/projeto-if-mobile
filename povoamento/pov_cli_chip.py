import random
import psycopg2 as pg




# PROGRAMA USADO PARA GERAR REGISTROS EM cliente_chip




def inserir(connection, idusuario, chips, ultimoChip):
    #linka um chip ao usuario
    chip = chips[ultimoChip][0]
    cursor = connection.cursor()
    cursor.execute(
        "INSERT INTO cliente_chip(idnumero, idcliente) VALUES (%s, %s)",
        (chip, idusuario, )
    )
    cursor.close()

    # definição do chip como ativo e indisponivel
    cursor = connection.cursor()
    cursor.execute(
        "UPDATE chip "
        "SET ATIVO = 'S', disponivel = 'N' "
        "WHERE idnumero = %s ",
        (chip, )
    )
    cursor.close()
    
    print("INSERT INTO cliente_chip(idnumero, idcliente) VALUES ("+str(chip)+","+str(idusuario)+");")

    ultimoChip += 1
    return ultimoChip

try:
    #conexão com o banco de dados
    connection = pg.connect(host='127.0.0.1', dbname='ifmobile', user='postgres', password='@1b2c3d4', port='5432')
    print("A conexão foi realizada com sucesso.")

    #query por todos os usuarios disponiveis
    cursor = connection.cursor()
    cursor.execute('SELECT * from cliente ORDER BY idcliente')
    registros = cursor.fetchall()
    cursor.close()


    #query por todos os chips disponiveis
    cursor = connection.cursor()
    cursor.execute('SELECT * from chip')
    chips = cursor.fetchall()
    cursor.close()

    #ponteiro para o id do ultimo chip associado
    ultimoChip = 0

    for usuario in registros:
        idusuario = usuario[0]

        n_chips = random.randint(1, 100)
        if n_chips <= 70:
            #linka um chip ao usuario
            ultimoChip = inserir(connection, idusuario, chips, ultimoChip)
        
        elif n_chips <= 90:
            #linka dois chips ao usuario
            for j in range(2):
                ultimoChip = inserir(connection, idusuario, chips, ultimoChip)

        elif n_chips <= 97:
            #linka tres chips ao usuario
            for j in range(3):
                ultimoChip = inserir(connection, idusuario, chips, ultimoChip)

        # entre 97 e 100 nao sao linkados chips ao usuario


    connection.commit()
    connection.close()
except pg.DatabaseError as dberr:
    print("Erro ao se conectar com o banco de dados: ", dberr)