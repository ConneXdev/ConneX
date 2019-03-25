// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef CONNEX_QT_CONNEXADDRESSVALIDATOR_H
#define CONNEX_QT_CONNEXADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class CONNEXAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CONNEXAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** CONNEX address widget validator, checks for a valid connex address.
 */
class CONNEXAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CONNEXAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // CONNEX_QT_CONNEXADDRESSVALIDATOR_H
