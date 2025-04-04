SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `exercicios` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `enunciado` text NOT NULL,
  `resposta` text NOT NULL,
  `criado_por` int(11) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `livros_didaticos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `autor` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `ano_publicacao` year(4) DEFAULT NULL,
  `disciplina` varchar(100) DEFAULT NULL,
  `arquivo_url` varchar(500) DEFAULT NULL,
  `criado_por` int(11) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `questoes` (
  `id` int(11) NOT NULL,
  `simulado_id` int(11) DEFAULT NULL,
  `enunciado` text NOT NULL,
  `alternativa_a` varchar(255) NOT NULL,
  `alternativa_b` varchar(255) NOT NULL,
  `alternativa_c` varchar(255) NOT NULL,
  `alternativa_d` varchar(255) NOT NULL,
  `alternativa_correta` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `resultados` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `simulado_id` int(11) DEFAULT NULL,
  `acertos` int(11) NOT NULL,
  `total_questoes` int(11) NOT NULL,
  `data_realizacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `resumos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `conteudo` text NOT NULL,
  `criado_por` int(11) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `simulados` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `criado_por` int(11) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('aluno','professor','admin') DEFAULT 'aluno',
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `tipo`, `criado_em`) VALUES
(1, 'Eric Barreto Melo de Almeida', 'ericbm.almeida@gmail.com', '$2y$10$eckIqIdPGNYEwoBi2Awwpeb2Fb5Z0yEPvm46dvT2KfRO.Ro.AKAue', 'aluno', '2025-03-25 23:10:17'),
(5, 'Isabel Moreira Ribeiro', 'isabelmr@gmail.com', '$2y$10$iqa2iBbmys2dgbW66laNAOE4MKg3QBBu.f/27uwhLXFCTHHh310rW', 'aluno', '2025-03-26 21:48:59');


ALTER TABLE `exercicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `criado_por` (`criado_por`);

ALTER TABLE `livros_didaticos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `criado_por` (`criado_por`);

ALTER TABLE `questoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `simulado_id` (`simulado_id`);

ALTER TABLE `resultados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `simulado_id` (`simulado_id`);

ALTER TABLE `resumos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `criado_por` (`criado_por`);

ALTER TABLE `simulados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `criado_por` (`criado_por`);

ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);


ALTER TABLE `exercicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `livros_didaticos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `questoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `resultados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `resumos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `simulados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


ALTER TABLE `exercicios`
  ADD CONSTRAINT `exercicios_ibfk_1` FOREIGN KEY (`criado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

ALTER TABLE `livros_didaticos`
  ADD CONSTRAINT `livros_didaticos_ibfk_1` FOREIGN KEY (`criado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

ALTER TABLE `questoes`
  ADD CONSTRAINT `questoes_ibfk_1` FOREIGN KEY (`simulado_id`) REFERENCES `simulados` (`id`) ON DELETE CASCADE;

ALTER TABLE `resultados`
  ADD CONSTRAINT `resultados_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `resultados_ibfk_2` FOREIGN KEY (`simulado_id`) REFERENCES `simulados` (`id`) ON DELETE CASCADE;

ALTER TABLE `resumos`
  ADD CONSTRAINT `resumos_ibfk_1` FOREIGN KEY (`criado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

ALTER TABLE `simulados`
  ADD CONSTRAINT `simulados_ibfk_1` FOREIGN KEY (`criado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
