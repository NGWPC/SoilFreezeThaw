#ifndef SFT_LOGGER_HPP
#define SFT_LOGGER_HPP

#include "ewts/module_constants.hpp"

// Provide the constant in the global namespace
inline constexpr const char* EWTS_ID_SFT = ewts::modules::EWTS_ID_SFT;

// Bind this module's logger identity
#define EWTS_ID EWTS_ID_SFT

#include "ewts/logger.hpp"

using ewts::EwtsInit;
using ewts::LogLevel;

#endif /* SFT_LOGGER_HPP */
