// Variables globales para el juego
let playerScore = 0; // Puntuación del jugador
let computerScore = 0; // Puntuación de la computadora o del jugador 2
let draws = 0; // Contador de empates
let attempts = 0; // Contador de intentos
let isTwoPlayerMode = false; // Modo de juego: un jugador (false) o dos jugadores (true)
let currentPlayer = 'player1'; // Para alternar entre jugador 1 y jugador 2
let player1Choice = ''; // Elección del jugador 1
let player2Choice = ''; // Elección del jugador 2

// Elementos del DOM
let resultText = document.getElementById('result-text'); // Elemento para mostrar el resultado
let playerScoreText = document.getElementById('player-score'); // Elemento para mostrar la puntuación del jugador
let computerScoreText = document.getElementById('computer-score'); // Elemento para mostrar la puntuación de la computadora o del jugador 2
let drawsText = document.getElementById('draws'); // Elemento para mostrar el contador de empates
let attemptsText = document.getElementById('attempt-count'); // Elemento para mostrar el contador de intentos
let playerChoiceDisplay = document.getElementById('player-choice'); // Elemento para mostrar la elección del jugador 1
let computerChoiceDisplay = document.getElementById('computer-choice'); // Elemento para mostrar la elección de la computadora o del jugador 2
let resetButton = document.getElementById('reset'); // Botón para reiniciar el juego
let switchModeButton = document.getElementById('switch-mode'); // Botón para cambiar entre modos de juego

// Mapa de opciones y sus imágenes
let choicesMap = {
    piedra: 'Imagenes/Firefly un dibujo de una piedra con cara tierna 56539.jpg', // Imagen para la opción "piedra"
    papel: 'Imagenes/Firefly un dibujo de un papel con cara tierna 53623.jpg', // Imagen para la opción "papel"
    tijera: 'Imagenes/Firefly un dibujo de una tijera con cara tierna 95552.jpg' // Imagen para la opción "tijera"
};

// Asignar eventos a los botones de elección del jugador
document.getElementById('player-piedra').onclick = function() { playGame('piedra'); };
document.getElementById('player-papel').onclick = function() { playGame('papel'); };
document.getElementById('player-tijera').onclick = function() { playGame('tijera'); };

// Función principal para jugar
function playGame(playerChoice) {
    if (isTwoPlayerMode) { // Si el modo es de dos jugadores
        if (currentPlayer === 'player1') { // Si es el turno del jugador 1
            player1Choice = playerChoice; // Guardar la elección del jugador 1
            currentPlayer = 'player2'; // Cambiar el turno al jugador 2
            resultText.textContent = 'Jugador 2, haz tu elección'; // Mostrar mensaje para el jugador 2
        } else { // Si es el turno del jugador 2
            player2Choice = playerChoice; // Guardar la elección del jugador 2
            currentPlayer = 'player1'; // Cambiar el turno al jugador 1
            playTwoPlayerGame(player1Choice, player2Choice); // Jugar la partida con ambas elecciones
        }
    } else { // Si el modo es de un jugador
        let computerChoice = getComputerChoice(); // Obtener la elección de la computadora
        playSinglePlayerGame(playerChoice, computerChoice); // Jugar la partida contra la computadora
    }
}

// Función para obtener la elección de la computadora (solo en modo un jugador)
function getComputerChoice() {
    let choicesArray = ['piedra', 'papel', 'tijera']; // Opciones posibles
    let randomIndex = Math.floor(Math.random() * choicesArray.length); // Obtener un índice aleatorio
    return choicesArray[randomIndex]; // Devolver la elección aleatoria
}

// Función para jugar en modo un jugador
function playSinglePlayerGame(playerChoice, computerChoice) {
    let result = determineWinner(playerChoice, computerChoice); // Determinar el ganador
    updateScores(result, 'player'); // Actualizar los puntajes
    displayResult(result, playerChoice, computerChoice); // Mostrar el resultado
    showChoices(playerChoice, computerChoice); // Mostrar las elecciones
    clearChoicesAfterDelay(); // Limpiar las elecciones después de un tiempo
}

// Función para jugar en modo dos jugadores
function playTwoPlayerGame(player1Choice, player2Choice) {
    let result = determineWinner(player1Choice, player2Choice); // Determinar el ganador
    updateScores(result, 'player1'); // Actualizar los puntajes
    displayResult(result, player1Choice, player2Choice); // Mostrar el resultado
    showChoices(player1Choice, player2Choice); // Mostrar las elecciones
    clearChoicesAfterDelay(); // Limpiar las elecciones después de un tiempo
}

// Función para determinar el ganador
function determineWinner(choice1, choice2) {
    if (choice1 === choice2) {
        return 'draw'; // Empate si ambas elecciones son iguales
    } else if (
        (choice1 === 'piedra' && choice2 === 'tijera') ||
        (choice1 === 'papel' && choice2 === 'piedra') ||
        (choice1 === 'tijera' && choice2 === 'papel')
    ) {
        return 'player1'; // Gana el jugador 1 si se cumplen estas condiciones
    } else {
        return 'player2'; // Gana el jugador 2 en otros casos
    }
}

// Función para actualizar los puntajes y texto de resultado
function updateScores(result, playerType) {
    if (result === 'player1') {
        playerScore++; // Aumentar la puntuación del jugador 1
    } else if (result === 'player2') {
        computerScore++; // Aumentar la puntuación del jugador 2 o computadora
    } else if (result === 'draw') {
        draws++; // Aumentar el contador de empates
    }

    playerScoreText.textContent = 'Jugador: ' + playerScore; // Actualizar el texto de la puntuación del jugador 1
    computerScoreText.textContent = 'Computadora: ' + computerScore; // Actualizar el texto de la puntuación de la computadora o jugador 2
    drawsText.textContent = 'Empates: ' + draws; // Actualizar el texto de los empates
    attempts++; // Aumentar el contador de intentos
    attemptsText.textContent = attempts; // Actualizar el texto de los intentos
}

// Función para mostrar las selecciones de jugador y computadora
function showChoices(choice1, choice2) {
    playerChoiceDisplay.innerHTML = '<img src="' + choicesMap[choice1] + '" alt="' + choice1 + '">'; // Mostrar la elección del jugador 1
    computerChoiceDisplay.innerHTML = '<img src="' + choicesMap[choice2] + '" alt="' + choice2 + '">'; // Mostrar la elección de la computadora o jugador 2
}

// Función para mostrar el resultado en pantalla
function displayResult(result, choice1, choice2) {
    if (result === 'player1') {
        resultText.textContent = 'Jugador 1 gana! ' + choice1 + ' vence a ' + choice2 + '.'; // Mensaje de victoria para el jugador 1
        resultText.style.color = 'green'; // Cambiar el color del texto a verde
    } else if (result === 'player2') {
        resultText.textContent = 'Jugador 2 gana! ' + choice2 + ' vence a ' + choice1 + '.'; // Mensaje de victoria para el jugador 2
        resultText.style.color = 'red'; // Cambiar el color del texto a rojo
    } else {
        resultText.textContent = 'Es un empate. Ambos eligieron ' + choice1 + '.'; // Mensaje de empate
        resultText.style.color = 'black'; // Cambiar el color del texto a negro
    }
}

// Función para reiniciar el juego
resetButton.onclick = function() {
    playerScore = 0; // Reiniciar la puntuación del jugador 1
    computerScore = 0; // Reiniciar la puntuación de la computadora o jugador 2
    draws = 0; // Reiniciar el contador de empates
    attempts = 0; // Reiniciar el contador de intentos
    playerScoreText.textContent = 'Jugador: ' + playerScore; // Actualizar el texto de la puntuación del jugador 1
    computerScoreText.textContent = 'Computadora: ' + computerScore; // Actualizar el texto de la puntuación de la computadora o jugador 2
    drawsText.textContent = 'Empates: ' + draws; // Actualizar el texto de los empates
    attemptsText.textContent = attempts; // Actualizar el texto de los intentos
    resultText.textContent = 'Haz tu elección para empezar a jugar.'; // Mensaje inicial
    resultText.style.color = 'initial'; // Restablecer el color del texto
    playerChoiceDisplay.innerHTML = ''; // Limpiar la elección del jugador 1
    computerChoiceDisplay.innerHTML = ''; // Limpiar la elección de la computadora o jugador 2
    currentPlayer = 'player1'; // Reiniciar el turno al jugador 1
};

// Función para cambiar entre modos de juego (un jugador / dos jugadores)
switchModeButton.onclick = function() {
    isTwoPlayerMode = !isTwoPlayerMode; // Alternar entre modos de juego
    switchModeButton.textContent = isTwoPlayerMode ? 'Cambiar a Un Jugador' : 'Cambiar a Dos Jugadores'; // Actualizar el texto del botón
    resultText.textContent = isTwoPlayerMode ? 'Jugador 1, haz tu elección' : 'Haz tu elección para empezar a jugar.'; // Mensaje según el modo
};

// Función para limpiar las selecciones después de un tiempo
function clearChoicesAfterDelay() {
    setTimeout(function() {
        playerChoiceDisplay.innerHTML = ''; // Limpiar la elección del jugador 1
        computerChoiceDisplay.innerHTML = ''; // Limpiar la elección de la computadora o jugador 2
    }, 3000); // Tiempo en milisegundos (3 segundos)
}

