{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "7dd89262-86bb-4fad-9609-b8111ec5f9cf",
   "metadata": {},
   "outputs": [
    {
     "name": "stdin",
     "output_type": "stream",
     "text": [
      "Enter file: clown.txt\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "the 7\n"
     ]
    }
   ],
   "source": [
    "name = input('Enter file:')\n",
    "handle = open(name)\n",
    "\n",
    "counts = dict()\n",
    "for line in handle:\n",
    "    words = line.split()\n",
    "    for word in words:\n",
    "        counts[word] = counts.get(word, 0) + 1\n",
    "\n",
    "bigcount = None\n",
    "bigword = None\n",
    "for word,count in counts.items():\n",
    "    if bigcount is None or count > bigcount:\n",
    "        bigword = word\n",
    "        bigcount = count\n",
    "\n",
    "print(bigword, bigcount)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "0e69b04c-c5ad-4b1d-9894-4adabe6aa56e",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.12.6"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
